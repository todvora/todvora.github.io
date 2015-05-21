---
layout: post
title: Agregace dat v MongoDB
date: '2014-02-08 06:47:28'
tags:
- mongodb
- aggregation framework
- map-reduce
---
Ze světa SQL známe formulaci GROUP BY. Jak se agregace řeší v dokumentové databázi, konkrétně v MongoDB? Probereme možnosti od vestavěných příkazů, přes Map-Reduce až po Aggregation Framework.

<h2>Nejprve nějaká data pro výpočty</h2>
<p>Začněme tím, že si vytvoříme kolekci, na které budeme agregaci testovat. Aby byla snadno pochopitelná a blízká českému prostředí, použijeme databázi českých PSČ.</p>
<p>Kolekci <a href="http://cs.wikipedia.org/wiki/JavaScript_Object_Notation">JSON</a> dokumentů připravených pro import vytvořil <a href="http://blog.pavek.net/o-autorovi/">Michal Pávek</a> (viz <a href="http://blog.pavek.net/2013/11/ceske-psc-pro-mongodb/">článek</a>) a zpřístupnil ji na <a href="https://github.com/MichalSpitfire/cz-zip-json">Githubu</a>. Odtud si ji můžeme snadno stáhnout:</p>
<p><code>wget https://raw.github.com/MichalSpitfire/cz-zip-json/master/cz_zip_codes.json</code></p>
<p>Data do MongoDB naimportujeme příkazem (předpokládám defaultní port a localhost):</p>
<p><code>mongoimport --db test --collection zips cz_zip_codes.json</code></p>
<p>Záznamy mají všechny stejné schéma, jeden konkrétní si vypišme:</p>
<pre class="prettyprint">> db.zips.findOne()
{
	"_id" : ObjectId("5288d5a858a1a95122432632"),
	"borough" : "Abertamy",
	"city" : "Abertamy",
	"district" : "Karlovy Vary",
	"zip" : 36235
}

</pre>
<p>V kolekci je 16755 dokumentů. Dostačující pro naše agregační hrátky. </p>
<pre class="prettyprint">> db.zips.count()
16755
</pre>
<h2>Agregační možnosti MongoDB</h2>
<p>MongoDB poskytuje tři hlavní způsoby, jak data agregovat. Každý k jinému použití a především jinak mocný a složitý. </p>
<h3>Vestavěné jednoúčelové funkce </h3>
<p>Nejjednodušší variantu agregačního příkazu už jsme si ukázali. Je jím metoda <a href="http://docs.mongodb.org/manual/reference/method/db.collection.count/#db.collection.count">count</a>. Ta spočítá všechny záznamy v kolekci. Je možné parametrem předat kritéria pro objekty, které budou do výsledku zahrnuty. Například takhle spočítáme objekty, které patří do okresu Karlovy Vary:</p>
<pre class="prettyprint">> db.zips.count({district:'Karlovy Vary'})
240
</pre>
<p>Další jednoúčelový příkaz je <a href="http://docs.mongodb.org/manual/reference/method/db.collection.distinct/#db.collection.distinct">distinct</a>, známý opět ze světa SQL. Vrátí seznam unikátních hodnot. Pro naši kolekci tedy:</p>
<pre class="prettyprint">> db.zips.distinct("district")
[
	"Karlovy Vary",
	"Trutnov",
	"Blansko",
	"Kutná Hora",
	"České Budějovice",
	"Jeseník",
	"Benešov",
	"Jindřichův Hradec",
	"Klatovy",
	...
</pre>
<p>(Všimněte si, že návratovou hodnotou je pole, nikoliv seznam objektů nebo text.)</p>
<p>Poslední z jednoúčelových funkcí je <a href="http://docs.mongodb.org/manual/reference/method/db.collection.group/#db.collection.group">group</a>. Slouží k jednoduché agregaci záznamů kolekce. Umožňuje nastavit klíč, podle kterého se bude agregovat, podmínku a JavaScriptovou funkci pro agregaci. Součty záznamů grupované přes okresy pak získáme:</p>
<pre class="prettyprint">> db.zips.group({key:{district:1}, reduce:function(cur, result){result.count += 1}, initial:{count:0}})
[
	{
		"district" : "Karlovy Vary",
		"count" : 240
	},
	{
		"district" : "Trutnov",
		"count" : 215
	},
	{
		"district" : "Blansko",
		"count" : 196
	},
	...
</pre>
<p> </p>
<p>Výhodou příkazu group je jednoduchá syntaxe a slušné možnosti pro jednodušší agregace. Navíc příkaz group existuje i ve starších verzích(před 2.2) MongoDB, které ještě neobsahují Aggregation Framework. Pozor na omezení velikosti výsledného dokumentu(16M) a maximální počet záznamů (10-20k podle verze db, viz <a href="http://docs.mongodb.org/manual/reference/command/group/#dbcmd.group">dokumentace</a>).</p>
<h2>Map-Reduce</h2>
<p>Map-Reduce je návrhový vzor využívaný v distribuovaném prostředí, při vykonávání paralelních operací nad velkým množstvím dat.</p>
<p>Funkce Map dostává ke zpracování objekt z databáze a jejím výsledkem je množina párů klíč-hodnota. Nad každým objektem je spuštěna funkce Map. Výsledky všech volání jsou pak předávány funkci Reduce, která hodnoty agreguje do výsledné formy. </p>
<p>Paralelní zpracování je výhodné především pokud máte kolekce v <a href="http://docs.mongodb.org/manual/sharding/">shardovaném</a> prostředí (jedna kolekce rozdělena na více samostatných databázových serverů).</p>
<p>Můj poněkud neobratný popis snad lépe pochopíte na <a href="http://cs.wikipedia.org/wiki/MapReduce">wikipedii</a>, z <a href="http://docs.mongodb.org/manual/core/map-reduce/">dokumentace MongoDB</a> nebo na <a href="http://nosql.mypopescu.com/post/543568598/presentation-mapreduce-in-simple-terms">jednoduchých obrázcích</a>. A teď už pojďme na nějaký příklad nad našimi PSČ.</p>
<p>Nejprve si pojďme pomocí Map-Reduce spočítat, kolik záznamů vlastně máme v kolekci (a snad tak získat stejný výsledek, jako při volání metody count). </p>
<pre class="prettyprint">> var map = function(){emit("count", 1)}
> var reduce = function(key, values){return Array.sum(values);}
> db.zips.mapReduce(map, reduce, {out:{inline:1}})
{
	"results" : [
		{
			"_id" : "count",
			"value" : 16755
		}
	],
	"timeMillis" : 447,
	"counts" : {
		"input" : 16755,
		"emit" : 16755,
		"reduce" : 168,
		"output" : 1
	},
	"ok" : 1,
}
> 
</pre>
<p>Nadefinovali jsme dvě funkce. Map, která emituje (vrací) jediný pár "count":1. A funkci Reduce, která postupně bere množiny výsledků a agreguje je - zde prostým součtem všech položek "count". Dopočetli jsme se ke stejnému výsledku, jako volání db.zips.count(). </p>
<p>Pojďme si teď zjistit, kolik záznamů máme pro jednotlivé okresy (district). Modifikujeme funkci Map, nebude už emitovat fixní klíč "count". Jako klíč nám poslouží název okresu, tedy dynamická vlastnost this.district. This odkazuje na aktuálně zpracovávaný objekt. Funkce Reduce se nemění.</p>
<pre class="prettyprint">> var map = function(){emit(this.district, 1)}
> var reduce = function(key, values){return Array.sum(values);}
> db.zips.mapReduce(map, reduce, {out:{inline:1}})
{
	"results" : [
		{
			"_id" : "Benešov",
			"value" : 595
		},
		{
			"_id" : "Beroun",
			"value" : 165
		},
		{
			"_id" : "Blansko",
			"value" : 196
		},
		...
</pre>
<p>Map-Reduce je jedna z mála operací, kdy dochází k opravdovému spuštění JavaScriptových funkcí na databázovém serveru. Funkce Map a Reduce poskytují dostatek možností pro libovolné výpočty nad daty. </p>
<p>Řekněme, že chceme spočítat, kolik je v kterém okrese záznamů takových, že jejich město začíná na písmeno 'E'. </p>
<pre class="prettyprint">> var map = function(){if(this.city.indexOf("E") == 0) { emit(this.district , 1)}}
> var reduce = function(key, values){return Array.sum(values);}
> db.zips.mapReduce(map, reduce, {out:{inline:1}})
{
	"results" : [
		{
			"_id" : "Litoměřice",
			"value" : 2
		},
		{
			"_id" : "Pelhřimov",
			"value" : 1
		},
		{
			"_id" : "Rokycany",
			"value" : 1
		},
		{
			"_id" : "Tachov",
			"value" : 3
		}
	],
	"timeMillis" : 286,
	"counts" : {
		"input" : 16755,
		"emit" : 7,
		"reduce" : 2,
		"output" : 4
	},
	"ok" : 1,
}
</pre>
<p>(Všimněte si, že ve funkci Map je definována JavaScriptová podmínka, která určuje v jaké situaci se bude emitovat.)</p>
<p>Výsledek můžeme ověřit ještě přímým vyhledáním konkrétních hodnot (filtrujeme pomocí regulárního výrazu nad polem 'city', ve výstupu pro přehlednost nevypisujeme _id a borough).</p>
<pre class="prettyprint">> db.zips.find( { city: /E.*/ } , {_id:0, borough:0});
{ "city" : "Erpužice", "district" : "Tachov", "zip" : 34901 }
{ "city" : "Ejpovice", "district" : "Rokycany", "zip" : 33701 }
{ "city" : "Erpužice", "district" : "Tachov", "zip" : 34901 }
{ "city" : "Eš", "district" : "Pelhřimov", "zip" : 39501 }
{ "city" : "Evaň", "district" : "Litoměřice", "zip" : 41002 }
{ "city" : "Evaň", "district" : "Litoměřice", "zip" : 41002 }
{ "city" : "Erpužice", "district" : "Tachov", "zip" : 34901 }
</pre>
<p>Opravdu, v kolekci je sedm takových záznamů, tři v Tachově, dva v Litoměřicích atd. </p>
<p>Funkce Reduce může počítat nejen prosté součty, ale i průměry a další agregační operace nad výsledkem funkce Map. Další příklady naleznete opět v <a href="http://docs.mongodb.org/manual/tutorial/map-reduce-examples/">dokumentaci</a>.</p>
<p>Ještě zmíním, co znamená výraz '{out:{inline:1}}' v každém z příkazů. Tím mongu říkáme, že chceme výstup přímo jako návratovou hodnotu, nikoliv ukládat do nějaké kolekce. Všechny možné hodnoty pro typ výstupu jsou popsány <a href="http://docs.mongodb.org/manual/reference/command/mapReduce/#out-options">zde</a>.</p>
<h2>Aggregation framework</h2>
<p><a href="http://docs.mongodb.org/manual/core/aggregation-pipeline/">Aggregation framework</a> je nejnovější a velmi snadno použitelný způsob, jak agregovat data v MongoDB. Funguje na principu <a href="http://cs.wikipedia.org/wiki/Roura_(Unix)">unixové pipeline</a> a jednoduchých modifikátorů(příkazů) transformujících data. Framework poskytuje podobné možnosti jako Map-Reduce, bez složitých zápisů JavaScriptových funkcí. A výkonově je často lepší než MR.</p>
<p>Vraťme se k příkladu s počítáním záznamů v jednotlivých okresech. Zápis v Aggregation Frameworku vypadá následovně:</p>
<pre class="prettyprint">> db.zips.aggregate([{$group:{_id:"$district", count:{$sum:1}}}}])
{
	"result" : [
		{
			"_id" : "Benešov",
			"count" : 595
		},
		{
			"_id" : "Beroun",
			"count" : 165
		},
		{
			"_id" : "Blansko",
			"count" : 196
		},
		...
</pre>
<p>Příkaz aggregate bere jako parametr pole. Pole proto, že je možné předat celou řadu modifikátorů dat. My použili zatím jediný $group. V něm jsme pak řekli, že data budou agregována podle klíče 'district'. A každý jeden objekt přičteme do proměnné 'count'.</p>
<p>Mezi další modifikátory (operátory) patří: </p>
<ul>
<li><a href="http://docs.mongodb.org/manual/reference/operator/aggregation/match/#pipe._S_match">$match</a> - filtruje dokumenty v pipeline. Zápis podmínky je obdobný jako u klasického find() - <em>$match:{district:"Bruntál"}</em></li>
<li><a href="http://docs.mongodb.org/manual/reference/operator/aggregation/sort/#pipe._S_sort">$sort</a> - seřadí dokumenty. Zápis pro seřazení dokumentů podle města sestupně - <em>$sort:{city:-1}  </em></li>
<li><a href="http://docs.mongodb.org/manual/reference/operator/aggregation/limit/#pipe._S_limit">$limit</a> - omezí počet dokumentů v pipeline. Zápis je <em>{$limit:5}</em></li>
<li><a href="http://docs.mongodb.org/manual/reference/operator/aggregation/limit/#pipe._S_limit">$skip</a> - přeskočí definovaný počet dokumentů. Zápis je <em>{$skip:10}</em></li>
<li><a href="http://docs.mongodb.org/manual/reference/operator/aggregation/project/#pipe._S_project">$project</a> - mocný operátor pro změnu struktury dokumentu. Umožňuje některé atributy vypustit, některé přejmenovat nebo změnit level zanoření atributu. </li>
<li><a href="http://docs.mongodb.org/manual/reference/operator/aggregation/unwind/#pipe._S_unwind">$unwind</a> - umožňuje rozložit pole na více nadřazených dokumentů. Jeden dokument obsahující pole je rozložen na tolik dokumentů, kolik elementů bylo v původním poli. Unwind opakem je k operátoru $group. </li>
<li><a href="http://docs.mongodb.org/manual/reference/operator/aggregation/group/#pipe._S_group">$group</a> - nejmocnější a nejužitečnější z operátorů. Dovede agregovat dokumenty a provádět výpočty nad množinami objektů. </li>
</ul>
<p>Jednotlivé operátory je možné libovolně řadit, kombinovat a opakovat. </p>
<p>Pokud budeme chtít pomocí Aggregation frameworku získat počet všech prvků v kolekci (jako vestavěné count nebo příklad u Map-Reduce):</p>
<pre class="prettyprint">> db.zips.aggregate([{$group:{_id:null, count:{$sum:1}}}])
{ "result" : [ { "_id" : null, "count" : 16755 } ], "ok" : 1 }
</pre>
<p>Jako klíč (_id), podle kterého agregujeme, je použita hodnota null. Jde o trik, kterým do jednoho klíče sečteme všechny hodnoty.</p>
<p>Řekněme, že chceme zjistit počty záznamů pro jednotlivé kraje (group podle district). Z nich pak vybrat pět největších. Zápis v Aggregation frameworku může vypadat:</p>
<pre class="prettyprint">> var group = {$group:{_id:'$district', count:{$sum:1}}}
> var sort = {$sort:{count:-1}}
> var limit = {$limit:5}
> db.zips.aggregate([group, sort, limit])
{
	"result" : [
		{
			"_id" : "Benešov",
			"count" : 595
		},
		{
			"_id" : "Klatovy",
			"count" : 495
		},
		{
			"_id" : "Příbram",
			"count" : 456
		},
		{
			"_id" : "České Budějovice",
			"count" : 385
		},
		{
			"_id" : "Tábor",
			"count" : 377
		}
	],
	"ok" : 1
}
</pre>
<p>A protože lze jednotlivé modifikátory libovolně opakovat a kombinovat, můžeme do kolony přidat další group. Dovedeme tak například sečíst počty pro okresy do výsledné hodnoty. Získáme celkový počet záznamů pro prvních pět nejpočetnějších okresů. Provádí se dvakrát za sebou group. </p>
<pre class="prettyprint"> var group = {$group:{_id:'$district', count:{$sum:1}}}
> var sort = {$sort:{count:-1}}
> var limit = {$limit:5}
> var total_group = {$group:{_id:null, count:{$sum:'$count'}}}
> db.zips.aggregate([group, sort, limit, total_group])
{ "result" : [ { "_id" : null, "count" : 2308 } ], "ok" : 1 }
</pre>
<h2>Kdy kterou metodu použít</h2>
<p>Pokud vám stačí jen zjistit počet záznamů nebo agregovat součty uložené v objektech (třeba sečti mi celkovou cenu výrobků, které splňují tuto podmínku), sáhněte po vestavěných příkazech.</p>
<p>U složitějších agregací výborně poslouží Aggregation Framework, kde nemusíte psát JS funkce a přitom je velmi mocný a kombinací operátorů se dá docílit mnoho funkcionalit.</p>
<p>Když vám přestane Aggregation Framework stačit, můžete si napsat sami Map-Reduce funkce a spustit ty. Pro opravdu velká data a složité agregace jde k MongoDB připojit <a href="http://docs.mongodb.org/ecosystem/use-cases/hadoop/">Apache Hadoop</a>.</p>
