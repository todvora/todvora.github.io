---
layout: post
title: Netbeans + Ubuntu + Compiz problém
date: '2008-04-13 08:04:03'
tags: []
image: '24'
---

Návod jak vyřešit problém s prázdnými okny na ubuntu při práci
v netbeans.


<p>Na obrázku je vidět(ze stránek sunu), že se zaplými compiz funkcemi pro
vzhled v ununtu 7.10 se některá okna v netbeans jeví jako
prázdná. Řešení je snadné:</p>

<ol>
	<li>Mít nejnovější javu (1.6)</li>

	<li>Do startup scriptu pro netbeans až nahoru vložit tuto řádku:</li>
</ol>

<pre><code>export AWT_TOOLKIT=MToolkit</code></pre>

<p>Skript by měl být k nalezení někde tady:</p>

<pre><code>/home/user_name/netbeans-6.0.1/bin</code></pre>

<p>Tohle vyřeší problém pro netbeans, je možné že při startu jiné
aplikace postavené na javě to bude vypadat obdobně, pak by to chtělo ten
export vložit někam ke startu javy,ale dosud jsem nepotřeboval, tak jsem
neřešil kam.</p>

<p><strong>Oprava:</strong>
<br />Po dni používání tohoto nastavení jsem narazil na další problém,
okno netbeans stratí focus, a nelze do něj psát do restartu aplikace.
Z návodů na fórech sem našel řešení. Místo Mtoolkit použít
XToolkit, tedy</p>

<pre><code>export AWT_TOOLKIT=XToolkit</code></pre>

<p>Uvidím zda toto nastavení již bude bezproblémové.</p>

