---
layout: post
title: Jak profiltrovat duplicitní buňky v OpenOffice Calc
date: '2009-08-19 13:08:11'
tags:
- openoffice
- tabulka
- duplicity
---

Jednoduchý návod, jak v openoffice odstranit duplicitní položky
v buňkách tabulky. Neexistuje na to totiž žádná automatizovaná
funkce.


<p>Protože neexistuje na odstranění duplicitních buněk žádná
automatizovaná funkce, která by je sama smazala, nezbývá než napsat pár
vzorců, buňky si seřadit a odmazat ručně. Jak tedy na to, krok po
kroku.</p>

<h2>1) Vybrat data a seřadit</h2>

<p>Myší, nebo například kliknutím do buňky a stiskem ctrl + * vyberte data
k seřazení. Následně volte data – řadit a seřaďte je podle
výchozího (přednastaveného) řazení.</p>

<h2>2) Vytvoření vzorce</h2>

<p>Klikněte myší do volné buňky v novém sloupci úplně nahoře
(předpokládejme B1). Vložte do ní tento vzorec:
<code>=IF(A1=A2;1;0)</code></p>

<h2>3) Kopírování vzorce</h2>

<p>Chytněte pravý dolní roh buňky se vzorcem a roztahněte přes všechny
žádky, obsahující data</p>

<h2>4) Zkopírování výsledku vzorce</h2>

<p>Nyní je důležité zkopírovat do schránky aktuálně vybrané buňky.
Dokud jsou označeny z předchozího kroku, stiskněte ctrl + c</p>

<h2>5) Vložení hodnot</h2>

<p>Zmáčněte ctrl + shift + v. Zobrazí se dialog pro speciální vložení.
Nechte zaškrtlé pouze čísla, ostatní odškrtněte.</p>

<h2>6) Seřazení všech dat</h2>

<p>Označte veškerá data, která v tabulce jsou, včetně slopce B,
který sme vytvořili a skládá se z 0 a 1. Následně volte data
– řadit a zvolte podle sloupce B</p>

<h2>7) Odstranění duplicit</h2>

<p>Označte veškeré řádky, které obsahují 1 ve sloupci B. Ty jsou
duplicitní, stiskněte delete, a v listu zbydou pouze unikátní
buňky.</p>

<p>Návod je volným překladem stránky: <a
href="http://wiki.services.openoffice.org/wiki/Documentation/How_Tos/Removing_Duplicate_Rows">http://wiki.services.openoffice.org/wiki/Documentation/How_Tos/Removing_Duplicate_Rows</a></p>

