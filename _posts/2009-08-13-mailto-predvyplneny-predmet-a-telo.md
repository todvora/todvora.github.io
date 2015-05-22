---
layout: post
title: ! 'Mailto: předvyplněný předmět a tělo'
date: '2009-08-18 08:53:48'
tags:
- html
- mailto
- e-mail
---

Url odkazu pro odeslání emailu pomocí odkazu mailto ma kupu zákonitostí,
pokusím se nastínit, který a proč použít. Také vysvětlím, jak vytvořit
odkaz s adresou, předmětem a předvyplněným tělem emailu.


<p>Určitě každý kdo se mihnul kolem tvorby webů narazil na potřebu uvést
na stránce svuj email. Klasická a známá varianta je toto :</p>

<p><code><a href="mailto:jmeno@server.cz">Napište
mi!</a></code></p>

<p>Méně lidí už ví, že se do takovéhoto odkazu dá zakomponovat
i předmět emailu.</p>

<p><code><a href="mailto:jmeno@server.cz?subject=Telo%20emailu">Odeslat
email!</a></code></p>

<p>Adresa pro odeslani emailu se skládá podle stejných zákonitostí jako url
adresa stránky.</p>

<p><code>protokol:adresa?parametr=hodnota_parametru&amp;druhy_parametr=druha_hodnota</code></p>

<p>Proto do odkazu můžeme vložit i tělo emailu. V ten okamžik ale
nastávají problémy s diakritikou, speciálními znaky, zlomy
řádků.</p>

<p>Platí, že minimálně <strong>tyto znaky by měly být
ošetřeny</strong>(nahrazeny za hexa hodnotu :</p>

<p>mezera : %20
<br />odřádkování : %0A
<br />středník: %3B</p>

<p><strong>Parametry, které se mohou objevit v url emailu :</strong>
<br />subject – předmět
<br />body – tělo emailu
<br />cc – kopie
<br />bcc – skrytá kopie</p>

<p>Výsledný plně využitý odkaz pak může vypadat třeba takto :</p>

<pre><code><a href="mailto:jmeno@server.cz?cc=jmeno2@server.cz
&amp;bcc=jmeno3@server.cz&amp;subject=Telo%20emailu
&amp;body=prvni%20radek%0Adruhy%20radek">Odeslat email!</a></code></pre>

<p>kde výsledný odkaz vypadá takto:
<br /><a
href="mailto:jmeno@server.cz?cc=jmeno2@server.cz&amp;bcc=jmeno3@server.cz&amp;subject=Telo%20emailu&amp;body=prvni%20radek%0Adruhy%20radek">Odeslat
email!</a></p>

