---
layout: post
title: Opera na Ubuntu - Java plugin
date: '2008-01-18 15:18:16'
tags:
- opera
- plugin
- jre
- linux
---

Návod na zprovoznění javy na Ubuntu 7.10 pro prohlížeč opera


<p>Pro zprovoznění javy na Ubuntu 7.10 je potřeba provést několik
kroků:</p>

<ol>
	<li>Instalace JRE(Java runtime enviroment)</li>

	<li>Povolení javy v opeře</li>

	<li>Uložení cesty k jre</li>
</ol>

<p><strong>Instalace javy</strong>
<br />V konzoli zadejte příkaz:
<br /><code>sudo apt-get install sun-java6-bin</code></p>

<p><strong>Povolení javy v opeře</strong>
<br />Jděte na:
„Nástroje“->„Nastavení“->„Pokročilé
volby“->„Obsah“-> zatržítko „povolit
javu“</p>

<p><strong>Uložení cesty k JRE</strong>
<br />Jděte na:
„Nástroje“->„Nastavení“->„Pokročilé
volby“->„Obsah“-> „nastavit javu“</p>

<p>do kolonky je třeba vyplnit cestu k JRE, zjistit se dá například
takto:
<br />V konzoli zadejte příkaz:
<br /><code>locate libjava.so</code></p>

<p>Vrátit by se Vám mělo něco jako
<br /><code>/usr/lib/jvm/java-6-sun-1.6.0.03/jre/lib/i386/libjava.so</code></p>

<p>kde nás zajímá pouze cesta,bez souboru libjava.so, tedy
<br /><code>/usr/lib/jvm/java-6-sun-1.6.0.03/jre/lib/i386/</code></p>

<p>tuto cestu překopírujte do pole v opeře, prohlížeč vypněte a
znovu zapněte. Applety by měly být již funkční.</p>

<p>Převzato z <a
href="https://help.ubuntu.com/community/Java">https://help.ubuntu.com/community/Java</a></p>

