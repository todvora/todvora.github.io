---
layout: post
title: Semestrální práce z KKY/VŘS
date: '2009-08-28 08:37:26'
tags:
- zču
- kky/vřs
- semestrální práce
---

Vypracovaný semestrální práce na ZČU z předmětu KKY/VŘS
(vložené řídící systémy) na téma PŘISTÁVÁNÍ RAKETY
V GRAVITAČNÍM POLI ZEMĚ


<h2>Téma práce : PŘISTÁVÁNÍ RAKETY V GRAVITAČNÍM POLI ZEMĚ</h2>

<p style="text-align:justify">Semestrální práce je téměř funkční,
zápočet jsem za ní dostal :) Trošku problém jsem měl s blokem
REXLang, který nebral můj zdrojový kód a pak jsem v diagramu
potřeboval aktuální čas, který se mi nepovedlo z REXu dostat, takže
je definován jako konstanta TIME_GENERATOR.</p>

<h2>Diagram v systému REX</h2>

<div><a href="/images/60.png"><img
src="http://www.tomas-dvorak.cz/images/60t.png" width="120" height="78"
/></a></div>

<h2>zdrojové kódy pro REX</h2>

<p>Zdrojové kódy práce jsou ke stažení: <a
href="/file_download/29">sp-kky-vrs.zip</a></p>

<h2>Dokumentace</h2>

<p>Dokumentace je ke stažení: <a href="/file_download/30"
title="Dokumentace k sp z KKY/VRS">dokumentace.pdf</a></p>

<h2>Návrh regulátorů</h2>

<p style="text-align:justify">Fyzická implementace regulátoru je realizována
pomocí funkčního bloku REXlang, který je standadním blokem prostředí REX.
Tento blok se skládá ze vstupů které lze mapovat na výstupy. Dále je
k dispozici možnost začlenit do bloku vlastní program ve formě
zdrojového kódu založeného na jazyku C. Tímto jednoduchým spojením je
dána možnost vytvářet bloky, které nejsou součástí prostředí REX.
V mém konkrétním příkladě je realizován jediný vstup, aktuální
rychlost rakety a jeden výstup akční veličiny Wrel. Regulátor je
realizován ve formě reléového, P, PI a PID. Integrální složka je
aproximována pomocí numerické metody lichoběžníkového pravidla a
derivační složka pomocí diferencí (rozdíl reálné a chybové veličiny)
Veškerá funkčnost je zřejmá ze zdrojových kódů.</p>

<pre><code>/**********************************************
* releovy regulator pro regulaci rychlosti rakety
**********************************************/
double input(3) aktualni_rychlost;
double input(4) pozadovana_rychlost;
double output(0) Wrel;
double parameter(0) Wmax;
double parameter(1) Wmin;
double e_t;
int main(void) {
    e_t = pozadovana_rychlost -
aktualni_rychlost;
    if (e_t > 0) {
        Wrel = Wmin
    } else {
        Wrel = Wmax
    }
    return 0;
}</code></pre>

<hr />

<pre><code>/**********************************************
* P regulator pro regulaci rychlosti rakety *
**********************************************/
double input(3) aktualni_rychlost;
double input(4) pozadovana_rychlost;
double output(0) Wrel;
double parameter(0) P;
double e_t;
int main(void)
{
e_t = pozadovana_rychlost - aktualni_rychlost;
Wrel += (P * e_t) ;
return 0;
}</code></pre>

<hr />

<pre><code>/**********************************************
* PI regulator pro regulaci rychlosti rakety *
**********************************************/
double input(3) aktualni_rychlost;
double input(4) pozadovana_rychlost;
double output(0) Wrel;
double parameter(0) P;
double parameter(1) I;
double e_t;
double sum_e = 0.0;
int main(void)
{
e_t = pozadovana_rychlost - aktualni_rychlost;
sum_e += e_t;
Wrel += (P * e_t) + (I * sum_e );
return 0;
}</code></pre>

<hr />

<pre><code>/***********************************************
* PID regulator pro regulaci rychlosti rakety*
***********************************************/
double input(3) cur_speed;
double input(4) req_speed;
double output(0) Wrel;
double parameter(0) P;
double parameter(1) I;
double parameter(2) D;
double e_t;
double sum_e = 0.0;
double last_speed = 0.0;
int main(void)
{
e_t = req_speed - cur_speed;
sum_e += e_t;
Wrel = (P * e_t) + (I * sum_e) - (D * (cur_speed
- last_speed));
last_speed = cur_speed;
return 0;
}</code></pre>

