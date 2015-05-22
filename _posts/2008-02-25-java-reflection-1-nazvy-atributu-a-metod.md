---
layout: post
title: Java - reflection 1 - názvy atributů a metod
date: '2008-02-25 14:36:10'
tags:
- java
- reflection
- metoda
- atribut
---

První ze série článků o java reflection, tedy o balíku
java.lang.reflect. Tentokrát o tom, jak získat názvy metod a
proměnných z konkrétní třídy.


<p>Tento článek se zabývá tím, jak automaticky, pomocí javy získat názvy
všech proměnných a metod ze třídy, a lehký úvod,jak s nimi
zacházet.</p>

<p>Pro představu si vytvoříme třídu JavaBean, která bude reprezentovat
třídu,ze které budeme dolovat informace. Její kód bude následující :</p>

<pre><code>public class JavaBean {

   private String Jmeno;
   private String Prijmeni;

    public String getJmeno() {
        return Jmeno;
    }

    public void setJmeno(String Jmeno) {
        this.Jmeno = Jmeno;
    }

    public String getPrijmeni() {
        return Prijmeni;
    }

    public void setPrijmeni(String Prijmeni) {
        this.Prijmeni = Prijmeni;
    }

    public String toString() {
        return this.Jmeno + &quot; - &quot; + this.Prijmeni;
    }
}</code></pre>

<p>a dále budeme potřebovat nějakou třídu main, kterou budeme využívat
k získávání informací o naší JavaBean třídě. Do ní budeme
psát následující kódy ( vždy pod kódem je vysvětlení, co se děje)</p>

<pre><code>JavaBean jb = new JavaBean();
Class c = jb.getClass();</code></pre>

<p>Vytvoříme novou instanci třídy JavaBean,a z ní následně do
proměnné c uložíme objekt reprezentující třídu JavaBean.
<br />V tomto kroku můžeme začít experimentovat s třídou
JavaBean tak,jak nám to rozhraní reflection dovoluje. Tedy postupně:</p>

<p><strong>Získání názvů deklarovaných metod:</strong></p>

<pre><code>Method[] poleMetod = c.getMethods();</code></pre>

<p>Do pole typu Method (java.lang.reflect.Method) se uloží všechny
definované a zděděné metody třídy JavaBean.
<br />S těmi pak můžeme pracovat dále, ať nás zajímají jen názvy
metod, nebo je budeme dále používat k volání jednotlivých metod.
Jejich názvy můžeme vypsat třeba takto:</p>

<pre><code>String[] nazvyMetod = new String[poleMetod.length];
           for (int i = 0; i &lt; poleMetod.length; i++) {
               nazvyMetod[i] = poleMetod[i].getName();
           }
           System.out.println(Arrays.toString(nazvyMetod));</code></pre>

<p>Voláním metody getName() nad metodou nám vrátí jen její název, bez
parametrů,navratových typů a modifikátorů. Výpis tohoto kousku kódu
vypadá přibližně takto:</p>

<pre><code>[getJmeno, setJmeno, getPrijmeni, setPrijmeni, toString,
hashCode, getClass, wait, wait, wait, equals, notify, notifyAll]</code></pre>

<p>Je vidět, že se nám vrátili nejen námi definované metody,ale
i metody zděděné z třídy Object.</p>

<p><strong>Získání názvů deklarovaných atributů:</strong></p>

<pre><code>Field[] poleAtributu = c.getDeclaredFields();</code></pre>

<p>V tomto kroku máme uloženy v poli typu Field
(java.lang.reflect.Field) všechny atributy třídy JavaBean.</p>

<p>Jejich názvy získáme obdobně jako u metod:</p>

<pre><code>String[] nazvyAtributu = new String[poleAtributu.length];
         for (int i = 0; i &lt; poleAtributu.length; i++) {
             nazvyAtributu[i] = poleAtributu[i].getName();
         }
         System.out.println(Arrays.toString(nazvyAtributu));</code></pre>

<p>Výstupem bude:</p>

<pre><code>[Jmeno, Prijmeni]</code></pre>

<p>Pro zajímavost uvedu výstupy tohoto kódu :</p>

<pre><code>System.out.println(Arrays.toString(poleMetod));
System.out.println(Arrays.toString(poleAtributu));</code></pre>

<p>Výstup:</p>

<pre><code>[public java.lang.String javareflections.JavaBean.getJmeno(),
public void javareflections.JavaBean.setJmeno(java.lang.String),
public java.lang.String javareflections.JavaBean.getPrijmeni(),
public void javareflections.JavaBean.setPrijmeni
(java.lang.String), public java.lang.String
javareflections.JavaBean.toString(), public native int
java.lang.Object.hashCode(), public final native java.lang.Class
java.lang.Object.getClass(), public final native void
java.lang.Object.wait(long) throws
java.lang.InterruptedException, public final void
java.lang.Object.wait(long,int) throws
java.lang.InterruptedException, public final void
java.lang.Object.wait() throws java.lang.InterruptedException,
public boolean java.lang.Object.equals(java.lang.Object), public
final native void java.lang.Object.notify(), public final native void
java.lang.Object.notifyAll()]


[java.lang.String javareflections.JavaBean.Jmeno,
java.lang.String javareflections.JavaBean.Prijmeni]</code></pre>

<p>Výstup je již značně nepřehledný, každopádně po bližším
prozkoumání lze vidět, že pole obsahuje modifikátor, návratový typ,
název metody a typy parametrů pro metody, a typ a název proměnné
u atributů</p>

<p><strong>Zavěr:</strong>
<br />Ukázali jsme si, jak lze jen podle názvu třídy zjistit informace jako
jsou názvy metod a atributů, a jak je procházet, vypisovat. Příště se
ponoříme hlouběji, do nastavování těchto atributů a volání metod.</p>

<p>Pro přdstavu k čemu by to mohlo být dobré: máme třídu typu <a
href="http://en.wikipedia.org/wiki/JavaBean">JavaBean</a> , kde zjistíme
všechny settery,nastavíme jim hodnotu,a vrátíme naplněný objekt. Nebo na
základě atributů zjistíme data z databáze, kterými naplníme objekt
(jednoduché objektově-relační mapování)</p>

<p><strong>Zdroje:</strong>
<br /><a href="http://java.sun.com/docs/books/tutorial/reflect/">java
tutorial</a></p>

