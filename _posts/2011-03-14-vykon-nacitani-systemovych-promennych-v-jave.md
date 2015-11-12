---
layout: post
title: Výkon načítání systémových proměnných v Javě
date: '2011-03-14 15:11:29'
tags:
- java
- system.getproperty
- proměnná
---

Každý kdo se někdy snažil zjistit z Javy informace
o prostředí na kterém běží se jistě setkal s metodou
System.getProperty(). Ta zpřístupňuje některé informace
o stroji, uživateli a umožnuje číst a nastavovat tyto hodnoty.
Přestože se properties chovají jako hash mapa, mají určité vykonostní
problémy. Provedeme porovnání rychlosti načítání hodnot ze systémových
proměnných a statické finální proměnné v Javě.


<pre><code>package com.ivitera.examples;

public class SystemEnvSpeed {

    private static final String PROPERTY_NAME = &quot;java.runtime.name&quot;;
    private static final String RUNTIME = System.getProperty(PROPERTY_NAME);
    private static final int LOOPS = 100000000;

    /**
     * Test rychlosti nacitani systemove property versus jednou nactene hodnoty
     * ulozene ve finalni staticke promenne tridy. Z vysledku je patrne, ze pokud
     * nepotrebujeme hodnotu aktualizovat za behu aplikace, je vyrazne lepsi
     * nacist ji jen jednou a zapamatovat si ji. Vykonovy propad je dan overovanim
     * povoleni pristupu k promenne v kazde obratce cyklu + pristupu do hashmapy
     * hodnot prostredi.
     */
    public static void main(String[] args) {

        long startPropertyReading = System.currentTimeMillis();
        String valueProperty = null;
        for (int i = 0; i &lt; LOOPS; i++) {
            valueProperty = System.getProperty(PROPERTY_NAME);
        }
        System.out.println(&quot;Value of &quot; + PROPERTY_NAME + &quot; is: &quot; + valueProperty);
        long timePropertyReading = System.currentTimeMillis() - startPropertyReading;
        System.out.println(&quot;System.getProperty took &quot; + timePropertyReading + &quot; ms&quot;);

        long startVariableReading = System.currentTimeMillis();
        String valueVariable = null;
        for (int i = 0; i &lt; LOOPS; i++) {
            valueVariable = RUNTIME;
        }
        System.out.println(&quot;Value of &quot; + PROPERTY_NAME + &quot; is: &quot; + valueVariable);
        long timeVariableReading = System.currentTimeMillis() - startVariableReading;
        System.out.println(&quot;Final variable took &quot; + timeVariableReading + &quot; ms&quot;);

        System.out.println(&quot;Reading static final property is &quot;
                + (timePropertyReading /  timeVariableReading)
                + &quot; faster than reading system property&quot;);
    }
}</code></pre>

<p><strong>Výstup</strong></p>

<pre><code>Value of java.runtime.name is: Java(TM) SE Runtime Environment
System.getProperty took 4754 ms
Value of java.runtime.name is: Java(TM) SE Runtime Environment
Final variable took 5 ms
Reading static final property is 950 faster than reading system property</code></pre>

