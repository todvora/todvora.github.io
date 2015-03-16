---
layout: post
title: Jak zkonvertovat PDF na sadu obrázků po stránce
date: '2011-04-12 14:56:57'
tags: []
---

Občas se hodí umět z jednoho PDF vyrobit sadu obrázků. Například
z katalogu ve formátu PDF vytvořit webovou prezentaci. Pomocí dvou
jednoduchých příkazů si ukážeme jak vygenerovat takovou sadu obrázků
z jednoho PDF. Také si ukážeme rozdíl mezi vyhlazeným a nevyhlazeným
výsledkem.


<p>Nejjednodušší přístup je vzít PDF soubor a pomocí Ghostscriptu
z něj vygenerovat obrázky po stránce, přesně tak jak chceme:</p>

<pre class=".prettyprint"><code>gs -q -dBATCH -dNOPAUSE -sDEVICE=jpeg -dJPEGQ88 -r150 -sOutputFile=%d.jpg katalog.pdf</code></pre>

<p>Příkaz projde celý PDF katalog a z každé stránky vytvoří jeden
obrázek se jménem 1.jpg až N.jpg.</p>

<p>Výsledek ale nebude vypadat dobře, obrázky nejsou vyhlazeny a vypadají
značně zubatě. Zvolíme tedy maličko jiný přístup, vygenerujeme sadu
obrázků ve velkém rozlišení a ty pak zmenšíme spolu
s vyhlazením.</p>

<pre class=".prettyprint"><code>gs -q -dBATCH -dNOPAUSE -sDEVICE=jpeg -dJPEGQ88 -r1500 -sOutputFile=%d.jpg katalog.pdf</code></pre>

<p>Jediná změna nastala v parametru -r, kde jsme rozlišení výrazně
zvětšili. V druhém kroku je třeba obrázky zmenšit a vyhladit</p>

<pre class=".prettyprint"><code>for img in *.jpg ; do convert $img -filter Lanczos -resize 10% -quality 90 resized-$img ; done</code></pre>

<p>Tento příkaz obrázky vzal a pomocí ImageMagicku zmenšil na 10% původní
velikosti. Zároveň provedl vyhlazení a výsledek vypadá o mnoho lépe.
Nyní můžeme porovnat výsledky s vyhlazením a bez vyhlazení, rozdíl
je značný.</p>

<p style="text-align:center"><a href="/images/74.jpg"><img
src="http://www.tomas-dvorak.cz/images/74t.jpg" alt="" /></a>
<br />Bez vyhlazení (rozklikněte pro zobrazení celého obrázku)</p>

<p style="text-align:center"><a href="/images/75.jpg"><img
src="http://www.tomas-dvorak.cz/images/75t.jpg" alt="" /></a>
<br />S vyhlazením (rozklikněte pro zobrazení celého obrázku)</p>

<p>Kód celého příkladu by mohl vypadat například takto:</p>

<pre class=".prettyprint"><code>#! /bin/bash

gs -q -dBATCH -dNOPAUSE -sDEVICE=jpeg -dJPEGQ88 -r150 -sOutputFile=low-%d.jpg katalog.pdf
gs -q -dBATCH -dNOPAUSE -sDEVICE=jpeg -dJPEGQ88 -r1500 -sOutputFile=high-%d.jpg katalog.pdf
for img in high-*.jpg ; do convert $img -filter Lanczos -resize 10% -quality 90 resized-$img ; done</code></pre>

<p>Vygeneruje z <em>katalog.pdf</em> tři sady obrázků, low-1.jpg –
low-N.jpg, v nízkém rozlišení bez vyhlazení, pak high-1.jpg až
high-N.jpg, obrázky ve vysokém rozlišení bez vyhlazení a pak
resized-high-1.jpg až resized-high-N.jpg, to jsou zmenšené a vyhlazené
obrázky ve vysokém rozlišení.</p>

<p>Zdroj: <a
href="http://www.perlmonks.org/?node_id=794918">http://www.per­lmonks.org/?no­de_id=794918</a></p>

