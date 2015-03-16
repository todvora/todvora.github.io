---
layout: post
title: Výkon dynamických proxy v Javě
date: '2011-03-14 20:08:34'
tags:
- java
- proxy
- test
---

Testování výkonu dynamických proxy v Javě. Dynamické proxy jsou
elegantní způsob jak řešit některé věci jako logování nebo
zabezpečení a pohodlnější než vytváření dekorátoru. To je ale
vykoupeno určitým výkonovým propadem. O kolik jsou pomalejší se
podíváme v krátkém testu.


<p><a
href="http://download.oracle.com/javase/6/docs/technotes/guides/reflection/proxy.html">Dynamická
proxy</a> v Javě je jakási obalující třída rozhraní, přes kterou
jdou veškerá volání rozhraní, které obaluje. Proxy navenek implementuje
všechna rozhraní, které má původní interface. Nutné je však
implementovat pouze jedinou metodu, <strong>public Object invoke(Object proxy,
Method m, Object[] args)</strong> . Skrz tuto metodu jdou veškerá volání
původního rozhraní. Umožní tak v jediném místě například
jednotné logování, zabezpečení přístupu, vše co si dovedete představit,
když dostanete úzké hrdlo k celému rozhraní. Protože je ale pak
konstrukce složitější, zajímal jsem se o výkon takového řešení.
Jak vypadal test:</p>

<pre class=".prettyprint"><code>package com.ivitera.examples;

import java.lang.reflect.Method;

public class ProxyPerformanceBenchmark {

    private static final int LOOPS = 1000000000;

    public static void main(String[] args) throws Exception {
        TestInterface proxyInstance = MyProxy.newInstance(new TestInterfaceImpl());
        TestInterface simpleInstance = new TestInterfaceImpl();

        long proxyStart = System.currentTimeMillis();
        for (int i = 0; i < LOOPS; i++) {
            proxyInstance.foo();
        }
        long proxyEnd = System.currentTimeMillis();

        long simpleStart = System.currentTimeMillis();
        for (int i = 0; i < LOOPS; i++) {
            simpleInstance.foo();
        }
        long simpleEnd = System.currentTimeMillis();

        System.out.println("Proxy instance run took "
                + (proxyEnd - proxyStart) + " ms");

        System.out.println("Simple instance run took "
                + (simpleEnd - simpleStart) + " ms");
        double percentsDiference = (100.0 / (simpleEnd - simpleStart))
                * (proxyEnd - proxyStart) - 100;
        System.out.println("Proxy calls are " + percentsDiference
                + "% slower than ordinal calls");
    }
}

interface TestInterface {
    void foo() throws Exception;
}

class TestInterfaceImpl implements TestInterface {
    private String value = null;
    private static final String PROPERTY_NAME = "java.runtime.name";

    public void foo() throws InterruptedException {
        value = System.getProperty(PROPERTY_NAME);
    }
}

class MyProxy implements java.lang.reflect.InvocationHandler {

    private TestInterface impl;

    public static synchronized <T extends TestInterface> T newInstance(T service) {
        return (T) java.lang.reflect.Proxy.newProxyInstance(service.getClass().getClassLoader(),
                service.getClass().getInterfaces(), new MyProxy(service));
    }

    private MyProxy(TestInterface service) {
        this.impl = service;
    }

    public Object invoke(Object proxy, Method m, Object[] args) throws Throwable {
        return m.invoke(impl, args);
    }
}</code></pre>

<hr />

<p>Výsledky testu jsou očekávané, volání která prochází skrz dynamickou
proxy jsou o něco pomalejší, v mém konkrétním testovaném
příkladu 1,7× pomalejší. To už není zanedbatelné u kritických
věcí kde se dějí tisíce přístupů v krátké době, při volání
metody jednou za požadavek to není problém. Výsledky testu odpovídají
i <a
href="http://ordinaryjava.blogspot.com/2008/08/benchmarking-cost-of-dynamic-proxies.html">jiným
měřením</a>, kde se autor testu dopočítal k hodnotě 1,6 násobku
standardního volání oproti proxy variantě.</p>

<p><strong>Výsledky:</strong></p>

<pre class=".prettyprint"><code>Proxy instance run took 108353 ms
Simple instance run took 61760 ms
Proxy calls are 75.44203367875647% slower than ordinal calls</code></pre>

<hr />

<p>Zdroje:
<br /><a
href="http://download.oracle.com/javase/6/docs/technotes/guides/reflection/proxy.html">http://downlo­ad.oracle.com/ja­vase/6/docs/techno­tes/guides/re­flection/proxy­.html</a>
<br /><a
href="http://www.ibm.com/developerworks/java/library/j-jtp08305.html">http://www.ib­m.com/developer­works/java/li­brary/j-jtp08305.html</a>
<br /><a
href="http://ordinaryjava.blogspot.com/2008/08/benchmarking-cost-of-dynamic-proxies.html">http://ordina­ryjava.blogspot­.com/2008/08/ben­chmarking-cost-of-dynamic-proxies.html</a>
<br /><a
href="http://blog.springsource.com/2007/07/19/debunking-myths-proxies-impact-performance/">http://blog.sprin­gsource.com/2007/07­/19/debunking-myths-proxies-impact-performance/</a></p>

