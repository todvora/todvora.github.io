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

## Nejprve nějaká data pro výpočty

Začněme tím, že si vytvoříme kolekci, na které budeme agregaci testovat. Aby byla snadno pochopitelná a blízká českému prostředí, použijeme databázi českých PSČ.

Kolekci [JSON](http://cs.wikipedia.org/wiki/JavaScript_Object_Notation) dokumentů připravených pro import vytvořil [Michal Pávek](http://blog.pavek.net/o-autorovi/) (viz [článek](http://blog.pavek.net/2013/11/ceske-psc-pro-mongodb/)) a zpřístupnil ji na [Githubu](https://github.com/MichalSpitfire/cz-zip-json). Odtud si ji můžeme snadno stáhnout:

`wget https://raw.github.com/MichalSpitfire/cz-zip-json/master/cz_zip_codes.json`

Data do MongoDB naimportujeme příkazem (předpokládám defaultní port a localhost):

`mongoimport --db test --collection zips cz_zip_codes.json`

Záznamy mají všechny stejné schéma, jeden konkrétní si vypišme:

```js
> db.zips.findOne()
{
	"_id" : ObjectId("5288d5a858a1a95122432632"),
	"borough" : "Abertamy",
	"city" : "Abertamy",
	"district" : "Karlovy Vary",
	"zip" : 36235
}
```

V kolekci je 16755 dokumentů. Dostačující pro naše agregační hrátky.

```js
> db.zips.count()
16755
```

## Agregační možnosti MongoDB

MongoDB poskytuje tři hlavní způsoby, jak data agregovat. Každý k jinému použití a především jinak mocný a složitý.

### Vestavěné jednoúčelové funkce

Nejjednodušší variantu agregačního příkazu už jsme si ukázali. Je jím metoda [count](http://docs.mongodb.org/manual/reference/method/db.collection.count/#db.collection.count). Ta spočítá všechny záznamy v kolekci. Je možné parametrem předat kritéria pro objekty, které budou do výsledku zahrnuty. Například takhle spočítáme objekty, které patří do okresu Karlovy Vary:

```js
> db.zips.count({district:'Karlovy Vary'})
240
```

Další jednoúčelový příkaz je [distinct](http://docs.mongodb.org/manual/reference/method/db.collection.distinct/#db.collection.distinct), známý opět ze světa SQL. Vrátí seznam unikátních hodnot. Pro naši kolekci tedy:

```js
> db.zips.distinct("district")
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
```

(Všimněte si, že návratovou hodnotou je pole, nikoliv seznam objektů nebo text.)

Poslední z jednoúčelových funkcí je [group](http://docs.mongodb.org/manual/reference/method/db.collection.group/#db.collection.group). Slouží k jednoduché agregaci záznamů kolekce. Umožňuje nastavit klíč, podle kterého se bude agregovat, podmínku a JavaScriptovou funkci pro agregaci. Součty záznamů grupované přes okresy pak získáme:

```js
> db.zips.group({key:{district:1}, reduce:function(cur, result){result.count += 1}, initial:{count:0}})
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
```

Výhodou příkazu group je jednoduchá syntaxe a slušné možnosti pro jednodušší agregace. Navíc příkaz group existuje i ve starších verzích(před 2.2) MongoDB, které ještě neobsahují Aggregation Framework. Pozor na omezení velikosti výsledného dokumentu(16M) a maximální počet záznamů (10-20k podle verze db, viz [dokumentace](http://docs.mongodb.org/manual/reference/command/group/#dbcmd.group)).

## Map-Reduce

Map-Reduce je návrhový vzor využívaný v distribuovaném prostředí, při vykonávání paralelních operací nad velkým množstvím dat.

Funkce Map dostává ke zpracování objekt z databáze a jejím výsledkem je množina párů klíč-hodnota. Nad každým objektem je spuštěna funkce Map. Výsledky všech volání jsou pak předávány funkci Reduce, která hodnoty agreguje do výsledné formy.

Paralelní zpracování je výhodné především pokud máte kolekce v [shardovaném](http://docs.mongodb.org/manual/sharding/) prostředí (jedna kolekce rozdělena na více samostatných databázových serverů).

Můj poněkud neobratný popis snad lépe pochopíte na [wikipedii](http://cs.wikipedia.org/wiki/MapReduce), z [dokumentace MongoDB](http://docs.mongodb.org/manual/core/map-reduce/) nebo na [jednoduchých obrázcích](http://nosql.mypopescu.com/post/543568598/presentation-mapreduce-in-simple-terms). A teď už pojďme na nějaký příklad nad našimi PSČ.

Nejprve si pojďme pomocí Map-Reduce spočítat, kolik záznamů vlastně máme v kolekci (a snad tak získat stejný výsledek, jako při volání metody count).

```js
> var map = function(){emit("count", 1)}
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
```

Nadefinovali jsme dvě funkce. Map, která emituje (vrací) jediný pár "count":1\. A funkci Reduce, která postupně bere množiny výsledků a agreguje je - zde prostým součtem všech položek "count". Dopočetli jsme se ke stejnému výsledku, jako volání db.zips.count().

Pojďme si teď zjistit, kolik záznamů máme pro jednotlivé okresy (district). Modifikujeme funkci Map, nebude už emitovat fixní klíč "count". Jako klíč nám poslouží název okresu, tedy dynamická vlastnost this.district. This odkazuje na aktuálně zpracovávaný objekt. Funkce Reduce se nemění.

```js
> var map = function(){emit(this.district, 1)}
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
```

Map-Reduce je jedna z mála operací, kdy dochází k opravdovému spuštění JavaScriptových funkcí na databázovém serveru. Funkce Map a Reduce poskytují dostatek možností pro libovolné výpočty nad daty.

Řekněme, že chceme spočítat, kolik je v kterém okrese záznamů takových, že jejich město začíná na písmeno 'E'.

```js
> var map = function(){if(this.city.indexOf("E") == 0) { emit(this.district , 1)}}
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
```

(Všimněte si, že ve funkci Map je definována JavaScriptová podmínka, která určuje v jaké situaci se bude emitovat.)

Výsledek můžeme ověřit ještě přímým vyhledáním konkrétních hodnot (filtrujeme pomocí regulárního výrazu nad polem 'city', ve výstupu pro přehlednost nevypisujeme _id a borough).

```js
> db.zips.find( { city: /E.*/ } , {_id:0, borough:0});
{ "city" : "Erpužice", "district" : "Tachov", "zip" : 34901 }
{ "city" : "Ejpovice", "district" : "Rokycany", "zip" : 33701 }
{ "city" : "Erpužice", "district" : "Tachov", "zip" : 34901 }
{ "city" : "Eš", "district" : "Pelhřimov", "zip" : 39501 }
{ "city" : "Evaň", "district" : "Litoměřice", "zip" : 41002 }
{ "city" : "Evaň", "district" : "Litoměřice", "zip" : 41002 }
{ "city" : "Erpužice", "district" : "Tachov", "zip" : 34901 }
```

Opravdu, v kolekci je sedm takových záznamů, tři v Tachově, dva v Litoměřicích atd.

Funkce Reduce může počítat nejen prosté součty, ale i průměry a další agregační operace nad výsledkem funkce Map. Další příklady naleznete opět v [dokumentaci](http://docs.mongodb.org/manual/tutorial/map-reduce-examples/).

Ještě zmíním, co znamená výraz '{out:{inline:1}}' v každém z příkazů. Tím mongu říkáme, že chceme výstup přímo jako návratovou hodnotu, nikoliv ukládat do nějaké kolekce. Všechny možné hodnoty pro typ výstupu jsou popsány [zde](http://docs.mongodb.org/manual/reference/command/mapReduce/#out-options).

## Aggregation framework

[Aggregation framework](http://docs.mongodb.org/manual/core/aggregation-pipeline/) je nejnovější a velmi snadno použitelný způsob, jak agregovat data v MongoDB. Funguje na principu [unixové pipeline](http://cs.wikipedia.org/wiki/Roura_(Unix)) a jednoduchých modifikátorů(příkazů) transformujících data. Framework poskytuje podobné možnosti jako Map-Reduce, bez složitých zápisů JavaScriptových funkcí. A výkonově je často lepší než MR.

Vraťme se k příkladu s počítáním záznamů v jednotlivých okresech. Zápis v Aggregation Frameworku vypadá následovně:

```js
> db.zips.aggregate([{$group:{_id:"$district", count:{$sum:1}}}}])
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
```

Příkaz aggregate bere jako parametr pole. Pole proto, že je možné předat celou řadu modifikátorů dat. My použili zatím jediný $group. V něm jsme pak řekli, že data budou agregována podle klíče 'district'. A každý jeden objekt přičteme do proměnné 'count'.

Mezi další modifikátory (operátory) patří:

*   [$match](http://docs.mongodb.org/manual/reference/operator/aggregation/match/#pipe._S_match) - filtruje dokumenty v pipeline. Zápis podmínky je obdobný jako u klasického find() - _$match:{district:"Bruntál"}_
*   [$sort](http://docs.mongodb.org/manual/reference/operator/aggregation/sort/#pipe._S_sort) - seřadí dokumenty. Zápis pro seřazení dokumentů podle města sestupně - _$sort:{city:-1}  _
*   [$limit](http://docs.mongodb.org/manual/reference/operator/aggregation/limit/#pipe._S_limit) - omezí počet dokumentů v pipeline. Zápis je _{$limit:5}_
*   [$skip](http://docs.mongodb.org/manual/reference/operator/aggregation/limit/#pipe._S_limit) - přeskočí definovaný počet dokumentů. Zápis je _{$skip:10}_
*   [$project](http://docs.mongodb.org/manual/reference/operator/aggregation/project/#pipe._S_project) - mocný operátor pro změnu struktury dokumentu. Umožňuje některé atributy vypustit, některé přejmenovat nebo změnit level zanoření atributu.
*   [$unwind](http://docs.mongodb.org/manual/reference/operator/aggregation/unwind/#pipe._S_unwind) - umožňuje rozložit pole na více nadřazených dokumentů. Jeden dokument obsahující pole je rozložen na tolik dokumentů, kolik elementů bylo v původním poli. Unwind opakem je k operátoru $group.
*   [$group](http://docs.mongodb.org/manual/reference/operator/aggregation/group/#pipe._S_group) - nejmocnější a nejužitečnější z operátorů. Dovede agregovat dokumenty a provádět výpočty nad množinami objektů.

Jednotlivé operátory je možné libovolně řadit, kombinovat a opakovat.

Pokud budeme chtít pomocí Aggregation frameworku získat počet všech prvků v kolekci (jako vestavěné count nebo příklad u Map-Reduce):

```js
> db.zips.aggregate([{$group:{_id:null, count:{$sum:1}}}])
{ "result" : [ { "_id" : null, "count" : 16755 } ], "ok" : 1 }
```

Jako klíč (_id), podle kterého agregujeme, je použita hodnota null. Jde o trik, kterým do jednoho klíče sečteme všechny hodnoty.

Řekněme, že chceme zjistit počty záznamů pro jednotlivé kraje (group podle district). Z nich pak vybrat pět největších. Zápis v Aggregation frameworku může vypadat:

```js
> var group = {$group:{_id:'$district', count:{$sum:1}}}
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
```

A protože lze jednotlivé modifikátory libovolně opakovat a kombinovat, můžeme do kolony přidat další group. Dovedeme tak například sečíst počty pro okresy do výsledné hodnoty. Získáme celkový počet záznamů pro prvních pět nejpočetnějších okresů. Provádí se dvakrát za sebou group.

```js
 var group = {$group:{_id:'$district', count:{$sum:1}}}
> var sort = {$sort:{count:-1}}
> var limit = {$limit:5}
> var total_group = {$group:{_id:null, count:{$sum:'$count'}}}
> db.zips.aggregate([group, sort, limit, total_group])
{ "result" : [ { "_id" : null, "count" : 2308 } ], "ok" : 1 }
```

## Kdy kterou metodu použít

Pokud vám stačí jen zjistit počet záznamů nebo agregovat součty uložené v objektech (třeba sečti mi celkovou cenu výrobků, které splňují tuto podmínku), sáhněte po vestavěných příkazech.

U složitějších agregací výborně poslouží Aggregation Framework, kde nemusíte psát JS funkce a přitom je velmi mocný a kombinací operátorů se dá docílit mnoho funkcionalit.

Když vám přestane Aggregation Framework stačit, můžete si napsat sami Map-Reduce funkce a spustit ty. Pro opravdu velká data a složité agregace jde k MongoDB připojit [Apache Hadoop](http://docs.mongodb.org/ecosystem/use-cases/hadoop/).
