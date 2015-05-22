---
layout: post
title: Java - najít a nahradit text
date: '2008-02-05 08:54:11'
tags:
- java
- regexp
- escape sekvence
---

Postup, jak zprovoznit nahrazování textu v javě (find and replace)
bez problémů s regulárními výrazy


<p><strong>Pro java 1.5 a výše:</strong></p>

<pre><code>text.replace("co","cim");</code></pre>

<p>kde nehrozí problémy se znaky využitými v regulárních
výrazech</p>

<p><strong>pro java do 1.5</strong>
<br />Java standartně obsahuje metodu pro nahrazování textů
v řetězci.</p>

<pre><code>text.replaceAll(regExp, nahrada);</code></pre>

<p>A tady začínají problémy. Jako první parametr chce java zadat
regulární výraz. Nás ale zajímá obyčejný text. Rozdíl je ten, že
v regulárním výrazu mají některé znaky svůj určitý význam.
A přesto že my nic takového nezamýšlíme, naše znaky jsou
internpretovány špatně. Jediná možnost je všechny řídící znaky
escapovat. Tedy před každý řídící znak vložit zpětné lomítko, např
„\$“ místo „$“. To je použitelné, pokud máme pevně
daný výraz, který budeme vyhledávat. Jinak je třeba zařídít, aby se
všechny významné znaky samy escapovaly.</p>

<p>Řídící znaky jsou tyto:</p>

<pre><code>String escapers = &quot;\\([{^$|)?*+.&quot;;</code></pre>

<p>Proto najít v textu řetězec „{obsah}“ a nahradit ho
naší textem je dosti komplikovaná úloha.</p>

<p>Lze však elegantně využít metody escapeCharacters. Použití je
jednoduché, projdeme celý řetězec,a všude kde se nachází řídící znak,
vložíme před něj lomítko.</p>

<pre><code>String regExp = escapeChars(text, escapers);</code></pre>

<p>Samotný kód metod je zde:</p>

<pre><code>private static String escapeChars(String string, String characters) {
       String result = string; //default;

       if (string != null &amp;&amp; characters != null) {
           StringCharacterIterator sci = new StringCharacterIterator(characters);
           char c = sci.first();
           boolean backslashEscaped = false;
           while (c != CharacterIterator.DONE) {
               if (c == '\\' &amp;&amp; !backslashEscaped) {
                   result = escape(result, c, '\\');
                   backslashEscaped = true;
               } else {
                   result = escape(result, c, '\\');
               }
               c = sci.next();
           }//next character
       }

       return result;
   }//escapeSpecialChars()

   public static String escape(String string, char character, char escape) {
       String result = string; //default;

       if (string != null) {
           StringBuffer sb = new StringBuffer();
           StringCharacterIterator sci = new StringCharacterIterator(string);
           char c = sci.first();
           while (c != CharacterIterator.DONE) {
               if (c == character) {
                   sb.append(escape);
               }
               sb.append(c);
               c = sci.next();
           }//next character
           result = sb.toString();
       }

       return result;
   }//escape()</code></pre>

<p>A použítí tohoto celku je už triviální:</p>

<pre><code>String regExp = escapeChars(co, escapers);
String poNahrazeni=text.replaceAll(regExp, cim);</code></pre>

<p>Převzato z <a
href="http://bugs.sun.com/bugdatabase/view_bug.do?bug_id=4948767">http://bugs.sun.com/bugdatabase/view_bug.do?bug_id=4948767</a></p>

<p>Uvedený postup pro java 1.4 a nižší funguje spolehlivě i pro
funkci replaceFirst() která i nadále očekává regulární výraz.</p>

