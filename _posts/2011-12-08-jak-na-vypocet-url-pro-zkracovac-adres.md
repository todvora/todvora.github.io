---
layout: post
title: Jak na výpočet URL pro zkracovač adres
date: '2011-12-08 19:22:28'
tags:
- zkracovač url
- hash
- bit.ly
---

Při návrhu vlastního zkracovače URL, obdoby služby bit.ly, jsem napsal jednoduchý algoritmus
výpočtu zkrácené URL, o který bych se rád podělil.


<p>Zkrácená URL mají smysl tam, kde:</p>

<ol>
	<li>Je omezen prostor pro text, například na Twitteru, který poskytuje jen
	140 znaků pro příspěvek</li>

	<li>Při generování QR kódů. Kratší URL bude mít jednodušší QR
	kód</li>

	<li>Chceme jednotný systém pro sdílení URL a monitorování jejich prokliků
	a refererů</li>
</ol>

<p>Smyslem algoritmu je získat url ve tvaru velmi podobném jako využívá
služba <a href="https://bitly.com/">bit.ly</a>, tedy například <a
href="http://bit.ly/tvAskx">bit.ly/tvAskx</a>, jako zkrácenina pro <a
href="http://www.tomas-dvorak.cz">http://www.tomas-dvorak.cz</a>.</p>

<p>Systém zkrácených URL jsem postavil na několika krocích:</p>

<ol>
	<li>Vložení url ke zkrácení do databáze, získání
	<strong>unikátního</strong> ID, pomocí autoincrement pole v tabulce či
	jinak. Tabulka má jednoduchou strukturu o dvou sloupcích:
	_autoincrement-ID_ | _original-url_</li>

	<li>Převedení tohoto číselného ID na tvar obdobný službě bit.ly (funkce
	<em>#toCode(long value)</em> )</li>

	<li>Sdílení linku ve tvaru domena.tld/_hash_</li>

	<li>Po kliknutí na link a spuštění obslužného kódu (není zde uveden)
	převedení hashe zpět na číslo (funkce <em>#fromCode(String hash)</em>
	)</li>

	<li>Dohledání správné URL v databázi, která má ID odpovídající
	získanému číslu</li>

	<li>Redirect na zjištěnou kompletní URL</li>
</ol>

<pre class=".prettyprint"><code>package com.ivitera.examples;

public class ShortUrlsUtils {
    public static final String ALPHABET =
            "0123456789" +
            "ABCDEFGHIJKLMNOPQRSTUVWXYZ" +
            "abcdefghijklmnopqrstuvwxyz";


    public static String toCode(long value) {
        int radix = ALPHABET.length();
        StringBuilder builder = new StringBuilder();
        do {
            builder.insert(0, ALPHABET.charAt((int) value % radix));
            value = value / radix;
        }
        while (value > 0);
        return builder.toString();
    }

    public static long fromCode(String s) {
        int radix = ALPHABET.length();
        s = s.trim();
        int pos = 0;
        long result = 0;
        while (pos < s.length() && !Character.isWhitespace(s.charAt(pos))) {
            String digit = s.substring(pos, pos + 1);
            int i = ALPHABET.indexOf(digit);
            if (i >= 0 && i < radix) {
                result *= radix;
                result += i;
                pos++;
            }
        }
        return result;
    }
}</code></pre>

<p>Utilita tedy převádí číselnou hodnotu v desítkové soustavě do
nové soustavy založené na definované abecedě. Pro představu několik
vzorových převodů:</p>

<table>
	<tr>
		<td><strong>Hodnota v desítkové soustavě</strong>   </td>

		<td><strong>Zkrácený kód</strong></td>
	</tr>

	<tr>
		<td>1234</td>

		<td>Ju</td>
	</tr>

	<tr>
		<td>555555</td>

		<td>2KWZ</td>
	</tr>

	<tr>
		<td>123456789</td>

		<td>8M0kX</td>
	</tr>
</table>

<p>Úspora délky je výrazná, více ukáže tabulka pro různé délky
kódů:</p>

<table>
	<tr>
		<td><strong>Délka kódu v nové soustavě (vypočtený hash)</strong>
		  </td>

		<td><strong>Délka v původní desítkové soustavě</strong>
		  </td>

		<td><strong>Počet ušetřených znaků</strong>   </td>

		<td><strong>Počet všech kombinací znaků o této délce (jaké
		maximální číslo jde zakódovat na daný počet znaků hashe)</strong></td>
	</tr>

	<tr>
		<td>1</td>

		<td>2</td>

		<td>1</td>

		<td>62</td>
	</tr>

	<tr>
		<td>2</td>

		<td>4</td>

		<td>2</td>

		<td>3844</td>
	</tr>

	<tr>
		<td>3</td>

		<td>6</td>

		<td>3</td>

		<td>238328</td>
	</tr>

	<tr>
		<td>4</td>

		<td>8</td>

		<td>4</td>

		<td>14776336</td>
	</tr>

	<tr>
		<td>5</td>

		<td>9</td>

		<td>4</td>

		<td>916132832</td>
	</tr>

	<tr>
		<td>6</td>

		<td>11</td>

		<td>5</td>

		<td>56800235584</td>
	</tr>

	<tr>
		<td>7</td>

		<td>13</td>

		<td>6</td>

		<td>3521614606208</td>
	</tr>

	<tr>
		<td>8</td>

		<td>15</td>

		<td>7</td>

		<td>218340105584896</td>
	</tr>

	<tr>
		<td>9</td>

		<td>17</td>

		<td>8</td>

		<td>13537086546263552</td>
	</tr>

	<tr>
		<td>10</td>

		<td>18</td>

		<td>8</td>

		<td>839299365868340224</td>
	</tr>
</table>

<p>Tedy pro ID <em>8392993658683­40224</em> v desítkové soustavě
získáme kód <em>zzzzzzzzzz</em>. Ušetřili jsme tak 8 znaků.</p>

<p>Pokud bychom chtěli sledovat, odkud byla zkrácená URL prokliknuta a
kolikrát, bylo by nutné před samotným přesměrováním na cílovou adresu
(krok 6) provést záznam refereru a zvýšení počtu návštěv do nějakého
systému pro záznam statistik.</p>

<p>Celý proces zkrácení URL a jejího použití by pak mohl vypadat
takto:</p>

<ol>
	<li>Chci zkrátit URL, například <a
	href="http://www.tomas-dvorak.cz/kategorie/Internet/">http://www.tomas-dvorak.cz/kategorie/Internet/</a>.
	V databázi mám vloženo již <em>12577</em> adres, které byly zkráceny.
	Vložím tedy tuto a vím, že její ID je <em>12578</em>.</li>

	<li>Převedu ID 12578 na zkrácenou formu, hash. Převodem metodou
	#toCode(12578) získám hash <em>3Gs</em></li>

	<li>Link, který budu dále sdílet je <em>domena.tld/3Gs</em></li>

	<li>Po kliknutí na link a spuštění obslužného kódu (není zde uveden)
	převedu hash <em>3Gs</em> zpět na ID, tedy zavolám funkci
	#fromCode(„3Gs“) a získám ID <em>12578</em>.</li>

	<li>Dohledání správné URL v databázi, která má ID odpovídající
	získanému číslu <em>12578</em>, výsledkem je původní adresa <a
	href="http://www.tomas-dvorak.cz/kategorie/Internet/">http://www.tomas-dvorak.cz/kategorie/Internet/</a></li>

	<li>Pošlu HTTP redirect na zjištěnou kompletní URL <a
	href="http://www.tomas-dvorak.cz/kategorie/Internet/">http://www.tomas-dvorak.cz/kategorie/Internet/</a></li>
</ol>

