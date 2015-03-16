---
layout: post
title: Java reflexe a neměnné proměnné
date: '2011-02-07 08:10:57'
tags:
- junit
- java
- reflexe
- test
- final
---

Způsoby, jak testovat neměnnost proměnných v javě


<p>Představte si třídu, která má na starosti jen držet nějaké konstanty,
třeba ID témat v databázi. Mohla by vypadat například takhle:</p>

<pre class="prettyprint"><code>package com.ivitera.examples;

import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

public class ObjectIDs {
    public static final long FIRST_SECTION_ID = 268;
    public static final long SECOND_SECTION_ID = 269;
    public static final Set<Long> TOPICS = Collections.unmodifiableSet(
            new HashSet<Long>(Arrays.asList(
                    FIRST_SECTION_ID,
                    SECOND_SECTION_ID
            )));
}</code></pre>

<p>To je asi ideální stav, proměnné jsou nastaveny jako
<strong>final</strong>, jejich hodnota tedy nepůjde předefinovat z venku.
V případě Setu je i přes modifikátor <strong>final</strong>
možné měnit hodnoty, do Setu přidávat nebo z něj mazat. Řešením je
<strong>Collections.un­modifiableSet()</strong>, která zajistí, že set
bude read-only. To jsou tedy základní požadavky, které budeme testovat,
final proměnné a u kolekcí to, že jsou neměnitelné. Jednoduchý jUnit
test by mohl vypadat takhle:</p>

<pre class="prettyprint"><code>package com.ivitera.examples;

import junit.framework.TestCase;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.Collection;

/**
 * Test na nemennost vsech kolekci v ObjectIDs, pokud jsou menitelne, nastavaji
 * velmi tezko odhalitelne chyby, kdy se nekde do kolekce zapise a rozbije se
 * tim cela aplikace
 */
public class ObjectIDsTest extends TestCase {

    public void testImmutability() {

        // reflexi vytahnu vsechny promenne tridy ObjectIDs
        final Field[] declaredFields = ObjectIDs.class.getDeclaredFields();
        for (Field field : declaredFields) {

            // KAZDA! promenna musi mit nastaveno ze je final, jinak ji bude
            // mozne zmenit zvenci
            final int modifiers = field.getModifiers();
            if (!Modifier.isFinal(modifiers)) {
                fail("Field '" + ObjectIDs.class.getName() + "#" + field.getName()
                        + "' has not 'final' modifier but should have one!");
            }

            // test, zda kazda z kolekci ktere vraci ObjectIDs je sama o sobe
            // nemenitelna. POZOR! muze nastat situace, ze sama kolekce je
            // nemenitelna, ale je backendovana jinou kolekci, ktera menit pujde.
            // To nevim jak otestovat.
            try {
                Object rawValue = field.get(null);
                if (rawValue instanceof Collection) {
                    Collection value = (Collection) rawValue;
                    int size = value.size();
                    try {
                        value.clear();
                        fail("Field '" + ObjectIDs.class.getName() + "#"
                                + field.getName()
                                + "' is mutable (clear method didnt failed)" +
                                " and should not be!");
                    } catch (UnsupportedOperationException e) {
                        // tohle je ok, vyjimka musi vyskocit!
                    }
                    if (size != value.size()) {
                        fail("Field '" + ObjectIDs.class.getName() + "#"
                                + field.getName()
                                + "'is mutable (clear changed collection size) " +
                                "and should not be");
                    }
                }
            } catch (IllegalAccessException e) {
                // nepovedlo se overeni, zadny problem by nemel nastat kdyz
                //  budu vyjimku ignorovat
                // a jen ji zaloguju
                e.printStackTrace();
            }
        }
    }
}</code></pre>

<p>To zajímavé z testu bych shrnul asi takto:</p>

<ul>
	<li>Reflexí projdeme všechny definované proměnné třídy</li>

	<li>pomocí <strong>field.getModi­fiers()</strong> získáme modifikátory
	proměnné,
	<br />následně metodou <strong>Modifier.isFi­nal(modifiers)</strong>
	ověříme, že je proměnná final. Tím ověříme první část požadavků,
	nemožnost změnit proměnné.</li>

	<li>Final nám ale nezajistí neměnitelnost kolekcí, je nutné tedy najít
	všechny potomky <strong>Collection</strong> a pokusit se ověřit, že je není
	možné měnit. To provedeme tak, že se pokusíme zavolat clear() a
	očekáváme vyjímku, následně ještě otestujeme změnu velikosti kolekce.
	To jsou indikátory co by mohli prozradit měnitelnost.</li>

	<li>Varianta, kterou nevím jak otestovat, je když je neměnitelná kolekce
	(např. <strong>Collections.un­modifiableSet()</strong>) vytvořena nad
	jinou kolekcí. Pokud se nám povede někudy změnit vnitřní kolekci a
	nebudeme přitom přistupovat k objektu vnější kolekce, nenastane
	vyjímka a změna se projeví!</li>
</ul>

<h2>Příklady</h2>

<p><strong>Chybějící modifikátor final:</strong></p>

<p>(Změněný zdroják ObjectIDs.java, odstraněn modifikátor final)</p>

<hr />

<pre class="prettyprint"><code>package com.ivitera.examples;

import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

public class ObjectIDs {
    public static final long FIRST_SECTION_ID = 268;
    public static long SECOND_SECTION_ID = 269;
    public static final Set<Long> TOPICS = Collections.unmodifiableSet(
            new HashSet<Long>(Arrays.asList(
                    FIRST_SECTION_ID,
                    SECOND_SECTION_ID
            )));
}</code></pre>

<hr />

<pre class="prettyprint"><code>junit.framework.AssertionFailedError: Field 'com.ivitera.examples.ObjectIDs#SECOND_SECTION_ID'
 has not 'final' modifier but should have one!
        at com.ivitera.examples.ObjectIDsTest.testImmutability(ObjectIDsTest.java:26)
        at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:39)
        at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:25)
        at com.intellij.rt.execution.junit.JUnitStarter.main(JUnitStarter.java:40)
        at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:39)
        at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:25)
        at com.intellij.rt.execution.application.AppMain.main(AppMain.java:90)</code></pre>

<hr />

<p><strong>Měnitelnost kolekce:</strong></p>

<p>(Změněný zdroják ObjectIDs.java, odstraněn
Collections.un­modifiableSet okolo setu)</p>

<hr />

<pre class="prettyprint"><code>package com.ivitera.examples;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class ObjectIDs {
    public static final long FIRST_SECTION_ID = 268;
    public static final long SECOND_SECTION_ID = 269;
    public static final Set<Long> TOPICS = new HashSet<Long>(Arrays.asList(
                    FIRST_SECTION_ID,
                    SECOND_SECTION_ID
            ));
}</code></pre>

<hr />

<pre class="prettyprint"><code>junit.framework.AssertionFailedError: Field 'com.ivitera.examples.ObjectIDs#TOPICS' is mutable
 (clear method didnt failed) and should not be!
        at com.ivitera.examples.ObjectIDsTest.testImmutability(ObjectIDsTest.java:41)
        at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:39)
        at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:25)
        at com.intellij.rt.execution.junit.JUnitStarter.main(JUnitStarter.java:40)
        at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:39)
        at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:25)
        at com.intellij.rt.execution.application.AppMain.main(AppMain.java:90)</code></pre>

<hr />

