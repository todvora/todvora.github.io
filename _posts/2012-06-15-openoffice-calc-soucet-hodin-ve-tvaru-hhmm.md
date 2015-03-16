---
layout: post
title: OpenOffice Calc - součet hodin ve tvaru HH:MM
date: '2012-06-15 13:41:21'
tags:
- openoffice
- calc
- vzorec
- sum
- tabulka
---
Návod, jak sečíst v OpenOffice Calc sloupec, kde jsou evidovány hodiny ve formátu HH:MM. Taková tabulka může představovat například výkaz času stráveného na projektu a zajímá nás, kolik hodin celkem bylo na projektu odpracováno.

<p>Tabulka s evidencí časů strávených na projektech může vypadat například takhle nějak:</p>
<table style="margin-left: auto; margin-right: auto;" rules="all">
<tbody>
<tr>
<td>1.6.2012</td>
<td>  6:35</td>
</tr>
<tr>
<td>2.6.2012</td>
<td>  2:15</td>
</tr>
<tr>
<td>...</td>
<td>  ...</td>
</tr>
<tr>
<td>12.6.2012</td>
<td>  5:50</td>
</tr>
</tbody>
</table>
<p>Našim cílem je sečíst  časy z každého řádku tak, aby výsledek byl ve formátu desetinného čísla. To lze například snadno využít jako podklad pro fakturaci.</p>
<p>K součtu využijeme funkce HOUR(value) a MINUTE(value), jejich popis je zhruba:</p>
<h3><span style="font-size: 14px;">HOUR(value)</span></h3>
<p>Vrátí hodiny uvedeného času. Pokud budeme mít čas (parametr funkce) 5:40, vrátí 5.</p>
<p>viz <a href="http://wiki.services.openoffice.org/wiki/Documentation/How_Tos/Calc:_HOUR_function">oficiální dokumentace k openoffice</a>.</p>
<h3><span class="c29" style="font-size: 14px;"><span class="c4">MINUTE(value)</span></span></h3>
<p>Vrátí minuty uvedeného času. Pokud budeme mít čas (parametr funkce) 5:40, vrátí 40.</p>
<p>viz <a href="http://wiki.services.openoffice.org/wiki/Documentation/How_Tos/Calc:_MINUTE_function">oficiální dokumentace k openoffice</a>.</p>
<p>Dovedeme tak relativně snadno sečíst a převést čas na hodiny jako desetinné číslo. Čas 5:40 tak funcí</p>
<p> </p>
<p><code class="prettyprint">=HOUR(buňka)+(MINUTE(buňka)/60)</code></p>
<p> </p>
<p>vypočíst hodnotu v hodinách ve formátu desetinného čísla:  5,66666666666667</p>
<p> </p>
<p>Stejný vzorec aplikujeme na každý řádek tabulky a nakonec funkcí <a href="http://wiki.services.openoffice.org/wiki/Documentation/How_Tos/Calc:_SUM_function">SUM()</a> provedeme součet přes všechny spočtené hodiny. Ty už pak lze například přenásobit sazbou na hodinu a fakturovat klientovi nebo použít jakkoliv jinak.</p>
<p>Pokud existuje jednodušší řešení, rád se o něm dozvím a prosím o jeho zapsání do komentáře k článku. Vím, že se jedná celkem o prkotinu ale hledání těch správných funkcí chvilku zabralo, proto si to sem poznamenávám a doufám, že se bude vzorec hodit i dalším.</p>
