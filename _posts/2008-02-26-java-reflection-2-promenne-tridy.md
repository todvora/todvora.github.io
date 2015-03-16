---
layout: post
title: Java - reflection 2 - proměnné třídy
date: '2008-02-26 20:07:02'
tags:
- Java
- reflection
- proměnná
---

Druhý ze série článků o java reflection, tedy o balíku
java.lang.reflect. Tentokrát o tom, jak nastavovat a získávat hodnoty
proměnných třídy


<p>V tomto příkladu budeme předpokládat existenci stejné třídy
JavaBean jako minule, tedy :</p>

<pre class="prettyprint"><code>public class JavaBean {

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
        return this.Jmeno + " - " + this.Prijmeni;
    }
}</code></pre>

<p>Dále potřebujeme třídu Main, ze které budeme provádět pokusy:</p>

<pre class="prettyprint"><code>public class Main {

    public static void main(String[] args) {
        try {
            JavaBean jb = new JavaBean();
            Class c = jb.getClass();

            ...</code></pre>

<p><strong>Čtení a zápis proměnných:</strong>
<br />V minulém díle bylo znázorněno,jak získat pole všech
proměnných, případně jejich názvů. Teď se zaměříme na jeden nějaký
konkrétní. Podmínkou následujících operací je to,že proměnné nejsou
s atributem private, tedy je třeba upravit třídu JavaBean
v deklaraci proměnných nějak takto:</p>

<pre class="prettyprint"><code>public class JavaBean {

    public String Jmeno;
    public String Prijmeni;

    ....</code></pre>

<p>Pak přístup k proměnné Jmeno získáme snadno:</p>

<pre class="prettyprint"><code>Field promennaJmeno= c.getDeclaredField("Jmeno");</code></pre>

<p>Nastavení hodnoty pak provedeme:</p>

<pre class="prettyprint"><code>promennaJmeno.set(jb,"Pavel");</code></pre>

<p>a získání hodnoty (v našem případě String) provedeme:</p>

<pre class="prettyprint"><code>String hodnotaJmeno=(String)promennaJmeno.get(jb);</code></pre>

<p><strong>Přístup k private atributům:</strong>
<br />Pokud jsou proměnné s atributem private,pak při pokusu
o jejich čtení nebo zápis dostaneme tuto vyjímku:</p>

<pre class="prettyprint"><code>java.lang.IllegalAccessException: Class javareflections.Main can
not access a member of class javareflections.JavaBean with
modifiers "private"</code></pre>

<p>Možnost,jak potlačit kontrolu přístupových atributů je taková:</p>

<pre class="prettyprint"><code>Field promennaJmenoPotlaceno= c.getDeclaredField("Jmeno");
 promennaJmenoPotlaceno.setAccessible(true);</code></pre>

<p>metoda setAccessible() nastavuje,zda java provede kontrolu atributu pro
přístup či nikoli. Parametrem je boolean, v případě true kontrolu
neprovádí, false kontrolu vynutí.
<br />Teď již není problém pracovat s proměnnou jako by žádný
přístupový modifikátor neměla, tedy:</p>

<pre class="prettyprint"><code>promennaJmenoPotlaceno.set(jb,"Pavel");
String hodnotaJmeno=(String)promennaJmenoPotlaceno.get(jb);</code></pre>

<p>Aniž bychom dostali jakékoli chybové hlášení.</p>

<p><strong><em>Varování:</em></strong> tímto postupem porušujeme veškerou
logiku JavaBeanu s privátními proměnnými a gettery a settery pro práci
s proměnnými, a můžeme tak snadno dosáhnout nekonzistentního stavu
JavaBeany, obejdeme možné kontroly a úpravy hodnot
v setterech…</p>

<p><strong>Modifikátory(A­tributy):</strong>
<br />Proměnná může mít tyto modifikátory:
<br />Přístupové atributy: public, protected, and private
<br />Atribut omezení na jednu instanci: static
<br />Atribut zakazující modifikace: final</p>

<p>Modifikátor dané proměnná získáme voláním:</p>

<pre class="prettyprint"><code>Field atribut = c.getDeclaredField("Jmeno");
Int modifikator = atribut.getModifiers();</code></pre>

<p>Návratová hodnota je typu int, vyjadřuje i několik modifikátorů
zároveň, pokud jich je více.
<br />Ideální test na ten či onen modifikátor je použít statické třídy
Modifier :</p>

<pre class="prettyprint"><code>Modifier.isPrivate(arg0);</code></pre>

<p>která vrací true/false podle toho,zda modifikátor je privátní. Těchto
testů je samozřejmě v třídě Modifier celá sada,na všechny
modifikátory.</p>

<p><strong>Typ proměnné:</strong>
<br />získání typu proměnné</p>

<pre class="prettyprint"><code>Field atribut = c.getDeclaredField("Jmeno");
Type typ = atribut.getType();</code></pre>

<p><strong>Zdroje:</strong>
<br /><a href="http://java.sun.com/docs/books/tutorial/reflect/">java
tutorial</a></p>

