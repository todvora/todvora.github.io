---
layout: post
title: JPA Multitenancy
date:   2015-12-11 18:50:16
tags:
  - JPA
  - Java
  - Hibernate
  - Dependency injection
image: /images/gitbook-tester/gitbook-tester.png
---

Multitenancy is a software architecture in which a single instance of a software runs on a server and serves multiple tenants. Software as a Service (SaaS) is a typical example of this approach. One server shared by many users, each with its own data.

In a hurry? [Jump straight to the source code!](https://github.com/todvora/jpa-multitenancy)

# Hibernate - not enough
Hibernate itself provides currently two levels of [multitenancy](https://docs.jboss.org/hibernate/orm/4.2/devguide/en-US/html/ch16.html):
- ```schema```: every tenant has its own schema in a shared database
- ```database```: every tenant has its own database instance

The base idea and implementation is, that you implement [CurrentTenantIdentifierResolver](https://docs.jboss.org/hibernate/orm/4.2/javadocs/org/hibernate/context/spi/CurrentTenantIdentifierResolver.html). It must always return a valid
schema name. There are no input parameters, so you have to read your underlying data eigther
from a static method or ThreadLocal storage. Based on this resolved name, a connection is
provided by [MultiTenantConnectionProvider](https://docs.jboss.org/hibernate/orm/4.2/javadocs/org/hibernate/service/jdbc/connections/spi/MultiTenantConnectionProvider.html).

unfortunately this approach does not allow much flexibility. You cannot switch
easily between tenants and many features in Hibernate itself do not play nicely with a
multitenant configuration. You are stuck with the Hibernate implementation, without
possibilities to adapt it to your needs.

# Custom JPA Solution

Goals:
- Separated schema for each tenant
- Single place of tenant injection
- Tenant unaware EJBs, without explicitly mentioning tenant when obtaining a connection
- Usage of the JTA transactions
- Injected a EntityManager instance, not any own factory or utility class
- No configuration of tenants in the persistence.xml or anywhere
- No restart / recompilation, when new tenant added

Some of the requirements are already solved in the article [Multi-Tenancy With EJB 3.1 and JPA 2.0](http://www.hostettler.net/blog/2012/11/20/multi-tenancy/). But there is still
the need of defining tenants manually in the ```persistence.xml``` and instead the
usual ```EntityManager``` only a wrapper is injected. It also contains only several
methods of ```EntityManager``` interface implemented. Overall good idea, but still
little bit clumsy to use and not that nice as I wished for. There must be a better way,
how to do that.

# ThreadLocal Tenant
We need one place, where tenant name will be stored. It should be available across threads,
session beans, simply anywhere, where tenant specific code could be executed. Something like
that could be enough:

```java
private static InheritableThreadLocal<String> currentTenantName = new InheritableThreadLocal<>();
```  

Lets say we want to provide a webservice, where every call will be tenant-aware:

![Tenant aware webservice](/images/multitenancy/webservice.png)

Everything between **set tenant name** and **clear tenant name** will have the
tenant name available through the ThreadLocal variable.

We could place it in a utility class and provide the read/write/remove methods to it. See [complete implementation](https://github.com/todvora/jpa-multitenancy/blob/master/src/main/java/cz/tomasdvorak/multitenancy/TenantHolder.java) of the ```TenantHolder``` utility class.

Last but not least, where to get the tenant name? You can read it from the [WebServiceContext](https://docs.oracle.com/javaee/6/api/javax/xml/ws/WebServiceContext.html), [HTTP Headers](http://examples.javacodegeeks.com/enterprise-java/jws/application-authentication-with-jax-ws/) or simply from the arguments of the call itself.

# Entity Manager factory
How to convert schema name to a connection?

```java
private EntityManagerFactory createEntityManagerFactory(String schemaName) {
     Map<String, String> props = new HashMap<>();
     props.put("hibernate.default_schema", schemaName);
     return Persistence.createEntityManagerFactory("test", props);
}
```

EntityManagerFactory is thread safe, can be cached and shared. It would be good to
create one entity manager factory for each tenant and hold them as long as possible. Good place for that is a **@Startup** **@Singleton** bean, that loads tenants from a configuration.

# Entity Manager
Now we have the tenant name available everywhere in our application logic. We are able
to create EntityManagerFactory and obtain an EntityManager from it.

We could use it in the places, where connection is needed:

```java
EntityManager em = TenantUtilities.getEntityManager(TenantHolder.getCurrentTenant());
```

But it would be much nicer and cleaner to not care about tenant at all and let
something handle it for us. Also we could leverage dependency injection too.

Usually you already have something like this in your single-tenant app:

```java    
@PersistenceContext
private EntityManager entityManager;
```

How to achieve that and provide our tenant-specific EntityManager, without any explicit calls mentioning tenant name?

# CDI to the rescue
With CDI we can supply our own implementations of objects injected by a container. And not
only some objects, but also the EntityManager!

```java
@RequestScoped
public class CustomEntityManager {

    @Produces
    EntityManager getEntityManager() {
        // create and return our own, tenant-specific connection.
    }
}
```

With a custom EntityManager producer you have to change only the annotation from @PersistenceContext to @Inject:

```java
@Inject
private EntityManager entityManager;
```

Cool! So now we can inject our own implementation or customization of an entityManager.
But it has one catch. The ```@Produces``` annotated method is called during injection time.
If we inject this entityManager to a Session Bean, we cannot control our EntityManager later.

We need some runtime wrapper over a EntityManager, that could check the tenant name
on every call of EntityManager and redirect the call to the right. Exactly that can provide a standard [dynamic proxy](https://docs.oracle.com/javase/8/docs/api/java/lang/reflect/Proxy.html) from Java SE. Lets create a Proxy inside **@Produces** annotated method getEntityManager with implementation like:

```java
return (EntityManager)Proxy.newProxyInstance(
  this.getClass().getClassLoader(),
  new Class<?>[] { EntityManager.class },
  (proxy, method, args) -> method.invoke(getCurrentEntityManager(), args)
);
```
On every call of EntityManger the proxy will be invoked and current entity manager, obtained from ```getCurrentEntityManager()``` method will be used. This solves our injection time problem. We are able to provide the right EntityManager during the actual call.

![Proxy entity manager](/images/multitenancy/proxy.png)

See the complete [ProxyEntityManager implementation](https://github.com/todvora/jpa-multitenancy/blob/master/src/main/java/cz/tomasdvorak/multitenancy/ProxyEntityManager.java).

## Webservice Interceptor
Back to our webservice. To keep its source code as clean as possible, we will
move the tenant logic initialization in own Interceptor:

```java
@AroundInvoke
public Object wrapWithTenant(final InvocationContext ctx) throws Exception {
    // read tenant from webservice invocation context
    TenantHolder.setTenant(readTenant(ctx));
    try {
        // executes the real webservice method
        return ctx.proceed();
    } finally {
        TenantHolder.cleanupTenant();
    }
}
```

The *@AroundInvoke* annotation ensures, that every WS method will be wrapped by our
```wrapWithTenant``` method. At this place, we are read tenant name from *InvocationContext* and set the tenant name to *ThreadLocal*.

See the complete [TenantInterceptor implementation](https://github.com/todvora/jpa-multitenancy/blob/master/src/main/java/cz/tomasdvorak/multitenancy/TenantInterceptor.java).

Now we have everything needed to provide clean, simple yet powerful JPA multitenancy.
Webservice interceptor, that reads tenant name from requests. ThreadLocal, that holds
this name. ProxyEntityManager, which can dynamically switch DB connections.

let's build an application, that will demonstrate all those pieces working together.

## Alice and Bob, observed by aliens.
Our common friends, [Alice and Bob](https://en.wikipedia.org/wiki/Alice_and_Bob) want
both keep a record of their tasks and write them down in a TODO-list app.

Each of them has its own account in the application. The application itself
stores their data separately in different schemas.



# Complete multitenancy schema

![Basic schema](/images/multitenancy/multitenancy.png)
