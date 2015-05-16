---
layout: post
title: JSHint a spouštění validace JavaScriptu z příkazové řádky
date: '2011-02-21 12:37:53'
tags:
- jshint
- jslint
- rhino
- javascript
- validace
- command line
- test
- java
---

Jak automatizovat statickou analýzu javascriptu pomocí JSHint (jslint) tak,
aby šla spouštět z příkazové řádky. Validační funkce je
definována v javascriptu, je tedy nutné spouštět javascriptový kód
z příkazové řádky.


<p>UPDATE: obdobná funkčnost té popsané v článku je již
v základu zahrnuta v projektu JSHint, více viz <a
href="https://github.com/jshint/jshint/blob/master/env/rhino.js">https://github­.com/jshint/jshin­t/blob/master/en­v/rhino.js</a></p>

<p>JSHint je javascriptová knihovna pro statickou analýzu zdrojových kódů
v JavaScriptu. V následujícím článku se pokusím vysvětlit, jak
tuto knihovnu používat z příkazové řádky k vlastní analýze
souborů.</p>

<p>Základní problém který je nutné vyřešit je jak spustit
z příkazové řádky javascriptový kód, když validace sama je
javascriptová funkce.</p>

<p>Stáhneme si knihovnu JSHint, například zde: <a
href="http://jshint.com/jshint.js">http://jshint­.com/jshint.js</a>, neměl
by být problém pro analýzu použít i standardní <a
href="http://www.jslint.com/">jslint</a>, pro ten však existují přímo
hotové command line nástroje, například <a
href="http://code.google.com/p/jslint4java/">jslint4java</a> . V článku
budeme dále pracovat jen s <a href="http://jshint.com/">JSHint</a> .</p>

<p>Javascript umí spouštět například Rhino, project mozilly, implementace
javascriptu v Javě (<a
href="http://www.mozilla.org/rhino/scriptjava.html">http://www.mo­zilla.org/rhi­no/scriptjava­.html</a>).
Konzoli javascriptu pak dovedeme pustit například příkazem</p>

<pre><code>java -cp .:js.jar org.mozilla.javascript.tools.shell.Main</code></pre>

<div><img src="/images/67.png" alt="rhino js console"
/></div>

<p><strong>js.jar</strong> je samotná implementace Rhina, stáhnout lze ze
stránek projektu (<a
href="http://www.mozilla.org/rhino/download.html">http://www.mo­zilla.org/rhi­no/download.html</a>).</p>

<p>To by byl první krok, dovedeme spustit z příkazové řádky
javascriptovou konzoli. Teď je nutné přesvědčit ji, aby v dávce
spustila náš validační kód a vytiskla výstup. Když předáme jako
parametr Rhinu cestu k souboru, začne automaticky vykonávat jeho kód.
Vytvoříme si tedy javascript, který spustí validaci a vytiskne výstup.</p>

<p>na stránce <a
href="https://developer.mozilla.org/en/Rhino_Shell">https://develo­per.mozilla.or­g/en/Rhino_She­ll</a>
je popsáno, jaké parametry Rhino akceptuje a zároveň jaké funkce nám
poskytuje. Využijeme tyto funkce:</p>

<p><strong>load([filename­,…])</strong></p>

<pre><code>Load JavaScript source files named by string arguments. If multiple
arguments are given, each file is read in and executed in turn.</code></pre>

<p><strong>print([expr…])</strong></p>

<pre><code>Evaluate and print expressions. Evaluates each expression, converts the
result to a string, and prints it.</code></pre>

<p><strong>readFile(path [, characterCoding])</strong></p>

<pre><code>Read given file and convert its bytes to a string using the specified character
coding or default character coding if explicit coding argument is not given.</code></pre>

<p>Kód samotného scriptu pro testování by mohl vypadat nějak tahle:</p>

<pre class="prettyprint"><code>// dodefinujeme funci trim pro stringy, abychom mohli orezavat evidence hodnoty
String.prototype.trim = function () {
    return this.replace(/^\s*/, "").replace(/\s*$/, "");
};

// funckce pro zkraceni nazvu souboru, odstraneni cesty
function onlyFilename(path) {
    parts = path.split("/");
    return parts[parts.length - 1];
}

// natahneme si z bin knihovnu jshint.js
load("bin/jshint.js");

// a iterujeme pres vsechny predane parametry, cesty k validovanym souborum
for (i in arguments) {
    // pocitadlo chyb, pro kazdy soubor zvlast
    var counter = 0;
    // samotna validace, vraci true/false pokud soubor obsahuje chyby
    var result = JSHINT(readFile(arguments[i]), "");
    if (!result) { // pokud neprosla validace

        // iteruji pres vsechny chyby a budu je pocitat a vypisovat
        for (var j in JSHINT.errors) {
            counter++;
            // aktualni chyba
            var error = JSHINT.errors[j];
            // muze byt null, pokud je nejaka fatalni, pole konci null
            if (error != null) {
                // nekdy je chyba bez dukazu, napriklad kdyz uz kontrola dal neprobiha, jen hlasi
                // ze chyb je moc a dal nepokracuje
                if ((typeof(error.evidence) != "undefined")) {
                    // naformatujeme vystup chyby, print je funkce rhina
                    print(onlyFilename(arguments[i]) + ":" + error.line + ":" + error.character
                            + ": " + error.evidence.trim() + "\n  " + error.reason);
                } else {
                    print(error.reason);
                }
                print("-----------");
            }
        }
        // result souboru, vytiskneme ze nalezl chyby a kolik jich bylo
        print("Error, file '" + arguments[i] + "' contains " + counter + " errors!")
    }
}</code></pre>

<p>Na začatku jsou definovány nějaké pomocné funce, jejich význam je jen
hezčí formátování výstupu. To důležité je níže</p>

<p><strong>load(„bin/jshin­t.js“);</strong> – naimportuje
z adresáře bin soubor <strong>jshint.js</strong>, to je naše testovací
knihovna, tu vložíme a tu pak budeme volat.</p>

<p><strong>JSHINT(readFi­le(arguments[i­]), "")</strong> –
spustí test, funkce <strong>readFile()</strong> je funkce z Rhina, která
umí načíst externí sobor (zdrojový kód k validaci). Návratová
hodnota globální funkce <strong>JSHINT</strong> je logická proměnná, zda
test prošel bez chyb či nikoli.</p>

<p><strong>arguments</strong> – pole z Rhina, které drží informace
o argumentech předaných z příkazové řádky. Tak můžeme jako
další parametr při spouštění Rhina předat cestu k souboru pro
zvalidování.</p>

<p><strong>JSHINT.errors</strong> – pole chyb jako výsledek validace,
přes něj budeme iterovat v případě že test neprošel a obsahuje
chyby.</p>

<p>Teď máme již vše připraveno, můžeme zkusit spustit test</p>

<p><strong>Vzorový javascript, který budeme validovat</strong></p>

<pre class="prettyprint"><code>function timeMsg() {
    var t = setTimeout("alertMsg()", 3000);
}
function alertMsg() {
    alert("Hello");
}</code></pre>

<p><strong>Příkaz</strong></p>

<pre><code>java -cp .:bin/js.jar org.mozilla.javascript.tools.shell.Main bin/runner.js example.js</code></pre>

<p><strong>Výstup validace</strong></p>

<pre><code>java -cp .:bin/js.jar org.mozilla.javascript.tools.shell.Main bin/runner.js bin/example.js
example.js:2:13: var t = setTimeout("alertMsg()", 3000);
  Implied eval is evil. Pass a function instead of a string.
-----------
Error, file 'bin/example.js' contains 1 errors!</code></pre>

<div><img src="/images/68.png"
alt="js validace - vysledky" /></div>

<p>Ve vzorovém javascriptu tedy byla nalezena chyba, kde se nachází a jaké
je její řešení je standardním výstupem validátoru.</p>

<p>Zdrojové kódy k tomuto článku včetně příkladu jsou ke stažení:
<a href="http://www.tomas-dvorak.cz/file_download/40">jsvalidation.zip</a></p>

<p><strong>Odkazy</strong>
<br /><a
href="http://www.mozilla.org/rhino/">http://www.mo­zilla.org/rhi­no/</a>
: Rhino (JavaScript for Java)
<br /><a href="http://jshint.com/">http://jshint­.com/</a> : JSHint
<br /><a href="http://www.jslint.com/">http://www.jslin­t.com/</a> : JSLint
<br /><a
href="http://code.google.com/p/jslint4java/">http://code.go­ogle.com/p/jslin­t4java/</a>
: jslint4java (command line tool)</p>

