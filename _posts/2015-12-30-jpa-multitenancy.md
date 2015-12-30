---
layout: post
title: JPA Multitenancy
date:   2015-12-30 13:50:16
tags:
  - JPA
  - Java
  - Hibernate
  - Dependency injection
  - Arquillian
image: /images/multitenancy/javaee.png
---

How to create a multitenancy architecture for JavaEE applications based on JPA and CDI, while keeping the source code as clean and simple as possible. Arquillian tests included!

## What is multitenancy
Multitenancy is a software architecture in which a single instance of a software runs on a server and serves multiple tenants. Software as a Service (SaaS) is a typical example of this approach. One server shared by many users, each with its own data.

**In a hurry? [Jump straight to the source code!](https://github.com/todvora/jpa-multitenancy)**

## Hibernate - not enough
Hibernate itself provides currently two levels of [multitenancy](https://docs.jboss.org/hibernate/orm/4.2/devguide/en-US/html/ch16.html):

- **schema**: every tenant has its own schema in a shared database
- **database**: every tenant has its own database instance

The base idea and implementation is, that you implement [CurrentTenantIdentifierResolver](https://docs.jboss.org/hibernate/orm/4.2/javadocs/org/hibernate/context/spi/CurrentTenantIdentifierResolver.html). It must always return a valid
schema name. There are no input parameters, so you have to read your underlying data eigther
from a static method or ThreadLocal storage. Based on this resolved name, a connection is
provided by [MultiTenantConnectionProvider](https://docs.jboss.org/hibernate/orm/4.2/javadocs/org/hibernate/service/jdbc/connections/spi/MultiTenantConnectionProvider.html).

Unfortunately this approach does not allow much flexibility. You cannot switch
easily between tenants and many features in Hibernate itself do not play nicely with a
multitenant configuration. You are stuck with the Hibernate implementation, without
possibilities to adapt it to your needs.

## Why custom solution

What do I want from a multitenancy application:

- Separated schema for each tenant
- Single place of tenant injection
- Tenant unaware EJBs, without explicitly mentioning tenant when obtaining a connection
- Usage of JTA transactions driven by application container
- Injection of a EntityManager instance, not any own factory or utility class
- No configuration of tenants in the persistence.xml
- No restart/recompilation, when new tenant added

Some of the requirements are already solved in the article [Multi-Tenancy With EJB 3.1 and JPA 2.0](http://www.hostettler.net/blog/2012/11/20/multi-tenancy/). But there is still
the need of defining tenants manually in the ```persistence.xml``` and instead the
usual ```EntityManager``` only a wrapper is injected. It also contains only several
methods of ```EntityManager``` interface implemented. Overall good idea, but still
little bit clumsy to use and not that nice as I wished for. There must be a better way,
how to do that. Let's try to do it in a different way.

## ThreadLocal Tenant
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

## Entity Manager factory
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

## Entity Manager
Now we have the tenant name available everywhere in our application logic. We are able
to create EntityManagerFactory and obtain an EntityManager from it.

We could use it in the places, where connection is needed:

```java
EntityManager em = TenantUtilities.getEntityManager(TenantHolder.getCurrentTenant());
```

But it would be much nicer and cleaner not to care about tenants at all and let
something handle it for us. We could leverage dependency injection too.

Usually you already have something like this in your single-tenant app:

```java    
@PersistenceContext
private EntityManager entityManager;
```

How to achieve that and provide our tenant-specific EntityManager, without any explicit calls mentioning tenant name?

## CDI to the rescue
With Contexts and Dependency Injection (CDI) we can supply our own implementations of objects injected by a container. And not
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

Cool! So now we can inject our own implementation or customization of an EntityManager.
But it has one catch. The ```@Produces``` annotated method is called during injection time.
If we inject this EntityManager to a Session Bean, we cannot control our EntityManager later.

We need some runtime wrapper over a EntityManager, that could check the tenant name
on every call of EntityManager and redirect the call to the right. Exactly that can provide a standard [dynamic proxy](https://docs.oracle.com/javase/8/docs/api/java/lang/reflect/Proxy.html) from Java SE. Let's create a Proxy inside **@Produces** annotated method getEntityManager with implementation similar to:

```java
(EntityManager)Proxy.newProxyInstance(
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
move the tenant logic initialization to a separate Interceptor:

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

The *@AroundInvoke* annotation ensures that every webservice call will be wrapped by our
```wrapWithTenant``` method. At this place, we read the tenant name from *InvocationContext* and set it to a *ThreadLocal* storage.

See the complete [TenantInterceptor implementation](https://github.com/todvora/jpa-multitenancy/blob/master/src/main/java/cz/tomasdvorak/multitenancy/TenantInterceptor.java).

The [webservice implementation](https://github.com/todvora/jpa-multitenancy/blob/master/src/main/java/cz/tomasdvorak/beans/TodoListServiceImpl.java) and all beans injected to it are pure, without any tenant logic and look exactly like in a single tenant application.

Now we have everything needed to provide clean, simple yet powerful JPA multitenancy.
Webservice interceptor, that reads tenant name from requests. ThreadLocal, that holds
this name. ProxyEntityManager, which can dynamically switch DB connections.

Let's build an application, that will demonstrate all those pieces working together.

## Alice and Bob, observed by aliens
Our common friends, [Alice and Bob](https://en.wikipedia.org/wiki/Alice_and_Bob) want
both to keep a record of their tasks and write them down in a TODO-list app.

Each of them has its own account in the application. The application itself
stores their data separately in different schemas. There is one *master* schema holding
information about tenants(=users) and their respective schemas.

To be able to test our multitenancy construct as a blackbox, without any internal
insights, we provide a webservice(JAX-WS) as the communication interface. Our test will be driven by [Arquillian](http://arquillian.org/), which prepares database, starts Wildfly application container and deploys webservice for us.

The test itself is rather simple. Alice creates one TODO item, Bob creates two
items and we verify, that both of them have the right TODOs stored in their schemas.

See the source code of this [test case](https://github.com/todvora/jpa-multitenancy/blob/master/src/test/java/cz/tomasdvorak/MultitenancyTest.java).

## Complete multitenancy schema
Following schema tries to summarize the complete flow of our multitenancy application.

![Basic schema](/images/multitenancy/multitenancy.png)

## Running this project & test

If you have Java 8 and Maven installed:

```
git clone https://github.com/todvora/jpa-multitenancy.git
cd jpa-multitenancy
mvn clean test
```
Or as a Docker project (no need of Java or Maven):

```
git clone https://github.com/todvora/jpa-multitenancy.git
cd jpa-multitenancy
docker build -t jpa-multitenancy .
docker run jpa-multitenancy
```

## Links, resources

- [Hibernate multitenancy](https://docs.jboss.org/hibernate/orm/4.2/devguide/en-US/html/ch16.html)
- [CDI Producer documentation](https://docs.jboss.org/weld/reference/1.0.0/en-US/html/producermethods.html)
- [Arquillian - getting started](http://arquillian.org/guides/getting_started/)
- [Class InheritableThreadLocal](https://docs.oracle.com/javase/6/docs/api/java/lang/InheritableThreadLocal.html)
- [Steve Hostettler - Multi-Tenancy With EJB 3.1 and JPA 2.0](http://www.hostettler.net/blog/2012/11/20/multi-tenancy/)
- [Github repository of this project](https://github.com/todvora/jpa-multitenancy)

Do you see room for improvement? Have you found a bug? Let me know in comments below or send a pull-request to the [project repository](https://github.com/todvora/jpa-multitenancy). Thanks!
