---
layout: post
title: Vy ještě neznáte MongoDB?
date: '2013-11-27 11:07:00'
tags:
- MongoDB
- java
- elearning
image: http://www.tomas-dvorak.cz/images/402.png
---
Aneb co jsem se naučil v kurzu MongoDB pro Java vývojáře a proč byste jej měli absolvovat také.

<p>Před pár dny jsem dokončil kurz <a href="https://university.mongodb.com/courses/10gen/M101J/2014_January/about">MongoDB for Java Developers</a> a jsem doslova nadšen. Perfektní elearning, zajímavá témata a mnoho tipů z praxe. Navíc je kurz zdarma a neklade nároky na přesný čas, kdy musíte u počítače sedět. Co víc si přát.</p>
<h2><img style="float: right; margin: 10px;" src="http://www.tomas-dvorak.cz/images/402.png" alt="" width="300" height="100" /></h2>
<h2>Proč si vůbec dělat kurz?</h2>
<p>S MongoDB už mám nějakou praxi, v posledním zaměstnání jsme nad ním postavili nástroj pro sledování návštěvnosti webů a dva roky jej vylepšovali a rozvíjeli. Kurz jsem si tedy zapsal pro to, abych ověřil, že nemám ve vzdělání mezery a nedělám něco vyloženě špatně.</p>
<p><strong>A musím uznat, mnoho jsem toho nevěděl a spoustu věcí dělal mizerně</strong>. Špatně jsem navrhoval <a href="http://docs.mongodb.org/manual/indexes/">indexy</a>, spoustu věcí počítal zbytečně až v aplikaci, protože jsem neznal <a href="http://docs.mongodb.org/manual/aggregation/">aggregation framework</a>.  </p>
<h2>Otevřené termíny</h2>
<p>Pokud vás MongoDB zajímá, neváhejte a zapište se taky. Termíny jsou následující:</p>
<p><a href="https://university.mongodb.com/courses/10gen/M101J/2014_January/about">MongoDB for Java developers</a>: 6.1.2014</p>
<p><a href="https://university.mongodb.com/courses/10gen/M101JS/2014_January/about">MongoDB for Node.js developers</a>: 13.1.2014</p>
<p><a href="https://university.mongodb.com/courses/10gen/M101P/2013_November/about">MongoDB for Python developers</a>: 25.11.2013</p>
<p><a href="https://university.mongodb.com/courses/10gen/M102/2013_December/about">MongoDB for DBAs (pro adminy)</a>: 9.12.2013</p>
<p> </p>
<h2>Organizace studia</h2>
<p>Každý týden přibývá nová sada přednášek, cvičení a domácích úkolů. Máte tak celý týden na studium a úkoly, nemusíte se časově přizpůsobovat.</p>
<p>Látka je probírána velmi srozumitelně, každé video má okolo 4 minut a po něm většinou následuje kvíz, abyste si ověřili, že jste téma dobře pochopili. Kvízy se nezapočítávají do finálního hodnocení.</p>
<p>Týdně musíte vypracovat domácí úkoly. Je jich zhruba 5 a každý zabere pár minut, půl hodiny maximálně. Často je zadáním naimportovat data, nad nimi provést nějaký výpočet a výsledek zadat zpět do elearningu. Nebo dostanete předpřipravený java projekt (blogový systém) a máte za úkol dopsat část funkcionality. Například načtení blogpostu podle jeho URL. </p>
<p>Pokud se vám povede dosáhnout 65% finálního hodnocení, obdržíte certifikát o absolvování kurzu (PDF e-mailem). Hodnocení je tvořeno z 50% domácími úkoly (3 pokusy na každé odevzdání, nejhorší týden není započítán) a z 50% závěrečným testem (10 otázek podobných těm v domácích úkolech). </p>
<p>Jestli umíte trochu s Javou, nebudete mít problém kurz absolvovat. Jde o jednoduchý kód a Java není v tomhle kurzu to podstatné. Seznámíte se s <a href="http://docs.mongodb.org/ecosystem/drivers/java/">driverem</a> pro MongoDB a naučíte se pracovat s daty, které vrací a bere jako parametry. Nic složitého.</p>
<p>Kurz je rozdělen do sedmi týdnů s následujícími tématy: </p>
<h2>Introduction</h2>
<p>Co je to nerelační/dokumentová/bezschémová databáze a proč ji použít? Jaké jsou rozdíly oproti relačním (např. MySQL) databázím?</p>
<p>V jakém formátu jsou data ukládána a načítána, co je <a href="http://www.json.org/json-cz.html">JSON</a> a <a href="http://bsonspec.org/">BSON</a>?</p>
<p>K absolvování kurzu na vašem PC bude potřeba instalace MongoDB, Maven, Java a PyMongo (pro validační scripty). Jak nástroje instalovat a nastavit, je také součástí této lekce.</p>
<h2>CRUD</h2>
<p><a href="http://docs.mongodb.org/manual/crud/">Create, Read, Update a Delete</a>. Základní operace pro práci s databází. Naučíte se, jak tvořit dotazy, konfigurovat kritéria a pracovat s dokumenty.</p>
<h2>Schema design</h2>
<p><a href="http://docs.mongodb.org/manual/data-modeling/">Modelování dat</a>, normalizace a denormalizace, vazby a embeddování dokumentů. Jak přejít ze světa relačních databází, kde jsou data rozsypána v mnoha tabulkách, do světa dokumentů. Kdy je normalizace zbytečná a kdy vhodným designem můžeme výrazně zlepšit výkon. Jak přežít bez transakcí?</p>
<h2>Performance</h2>
<p><a href="http://docs.mongodb.org/manual/indexes/">Indexy</a> nad kolekcemi, profilování query, <a href="http://docs.mongodb.org/manual/reference/method/cursor.explain/">explain</a> příkaz pro lepší porozumění zpracování dotazu. Naučíte se pracovat s MongoDB tak, aby databáze nezdržovala a nebyla nejslabším článkem řetězu.</p>
<h2>Aggregation</h2>
<p><a href="http://docs.mongodb.org/manual/aggregation/">Framework pro agregaci dat</a>, pro mě největší překvapení a nejzajímavější část. Mongo umí pracovat nad kolekcí metodou pipeline, známou z unixového světa. Můžete řetězit bloky za sebe a filtrovat, aggregovat a transformovat data. Velmi elegantně tak jde řešit group by z SQL světa a mnoho dalších problémů. </p>
<h2>Application engeneering</h2>
<p><a href="http://docs.mongodb.org/manual/replication/">Replikace</a>, <a href="http://docs.mongodb.org/manual/sharding/">sharding</a>, <a href="http://docs.mongodb.org/manual/core/write-concern/">write concern</a>. Jak škálovat databázi, zajistit odolnost proti výpadkům a zvýšit výkon řešení. </p>
<h2>Case studies + final exam</h2>
<p>Případové studie z foursquare a codeacademy. Tato lekce nemá domácí úkoly ani kvízy, je ale třeba vypracovat 10 otázek pro finální zkoušku. Nejste limitováni pokusy a výsledky se zpracují až na konci týdne. Do té doby můžete své odpovědi měnit.</p>
<h2>Jak jsem dopadl já?</h2>
<p>Moc jsem si kurz užil a už vybírám další, na který se vrhnu. Buď to bude kurz pro adminy nebo Node.js vývojáře. A z toho pro Javu mám 100% :-)</p>
<h2>Další kurzy, jiná témata</h2>
<p>Velmi pěkný souhrn kurzů a zdrojů sepsal Michal Pávek na svém blogu: <a href="http://blog.pavek.net/2013/10/online-kurzy-podzim-2013/">http://blog.pavek.net/2013/10/online-kurzy-podzim-2013/</a></p>
