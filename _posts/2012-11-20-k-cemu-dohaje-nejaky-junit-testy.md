---
layout: post
title: K čemu doháje nějaký jUnit testy?
date: '2012-11-25 16:46:05'
tags:
- testy
- junit
- continuous integration
---
Kód přece píšu už roky, kvalitně a dávám si na chyby pozor. Jasně, že když to programuju, tak zkusím, zda metoda dělá, co má. Tak proč bych se měl patlat s nějakýma testama? Akorát to žere čas a zdržuje od práce.

<p>Je vám ten přístup povědomej? Nějakou dobu mi trvalo, než jsem pochopil, že jsou to jen kecy a výmluvy. Testy mi usnadňujou vývoj, krejou záda, když dělám refactoring. Zajišťujou, že se mi nestane stejná chyba dvakrát. Díky testům navrhuju kvalitnější rozhraní. </p>
<p>Nemá smysl ukazovat tady další příklad z mnoha. Rozeberu jen těch pár bodů, kvůli kterým si myslím, že stojí zato psát jednotkové testy.</p>
<h1>Neopakuji tutéž chybu znovu</h1>
<p>Jakmile nějakou situaci podchytím v testu, vím, že už se mi stejná chyba znovu nestane. Test to zaručuje. Od teď a napořád. Pokud testuji metodu ověřující platnost emailu a zjistím, že je možné zadat v mailu mezeru, začnu testem. Napíšu takovou podmínku, která ověřuje, zda je email s mezerou neplatný. Test ihned začne failovat. Vím, že pokud udělám opravu kódu a mezery zakážu, test začne fungovat a já mám chybu vyřešenou a pokrytou. Napořád. A od teď už zadarmo.</p>
<h1>Píšu lepší rozhraní</h1>
<p>Když chci kód testovat, zjistím, že moje metody často potřebují zcela zbytečné objekty. Pokud metoda pro validaci emailu bere na vstupu HttpRequest, dost těžko to budu simulovat v testu. Proč nebere prostý String? Natrénuji lépe dependency injection. Při inicializaci service podstrčím objekt, který dovedu vyrobit v testu a ne něco, co mi poskytuje framework nebo servlet kontejner. Vstupní parametry omezuji na minimum a co nejjednodušších objektů.</p>
<h1>Když refaktoruju kód, nemám nervy na pochodu</h1>
<p>Jakmile mám pokrytej kód testama, můžu do něj zasahovat a nemusím se tolik bát, že najednou přestal fungovat. Vím, že validaci emailu mám otestovanou na všechny možný a nemožný vstupy, který mě napadly. Pokud se tedy začnu rejpat v samotým validátoru a testy pořád fungujou, dost možná jsem vůbec nic nerozbil. Pokud bych testy neměl, při každý změně můžu jen doufat, že validace stále validuje. Nebojím se tak říznout i do kódu, kterej bych jinak raději potichu obešel. Když chci refaktorovat cizí kód, kterej je opravdu hnusnej a bojím se, že něco rozbiju, začnu testem. Jakmile mám test, šance na to, že zničím původní funkcionalitu je mnohem nižší a moje znalost kódu mnohem vyšší.</p>
<h1>Testy vedou k pochopení kódu</h1>
<p>Na to, abych mohl napsat dobrej test musím vědět, co testovanej objekt dělá. Musím pochopit, jaký jsou legální a nepovolený vstupy a výstupy. Jaký má závislosti, čím se inicializuje. Co jí podstrčit, aby zhavarovala a na co má reagovat dobře. Když tohle všechno dovedu, vím o metodě dost na zápis pěknýho testu. A navíc jsem se naučil zase o kus víc o aplikaci, na který dělám.</p>
<h1>Snáz se mi píše kód</h1>
<p>Jak píšete validátor pro email? Musíte přece nějak zkoušet, zda to reaguje, co vrací a který adresy projdou a který ne. Přece nebudu zadávat dokola do formuláře na webu emaily a koukat, co vrací. Nebo donekonečna ručně spouštět main metodu, která na začátku volá System.out.println. Já to chci jednou zanést do kódu a pak už jen dokola spouštět. Napíšu si test, vyjmenuju v něm možný a nemožný kombinace a začnu psát validátor. Tak dlouho upravuju validátor, dokud test failuje. </p>
<h1>Automatika mi hlídá chyby všech členů týmu</h1>
<p>Testy spouší continuous integration server. Každej commit otestuje. A vždycky spustí ty desítky, stovky testů. Takže i když se ve vašem kódu hrabe někdo jinej a rozbije ho, vy o tom víte. Server nikdy nevynechá, neodflákne to, protože je unavenej. A krom elektřiny to nestojí vůbec nic. S trochou námahy na začátku získáte obrovskej kus jistoty do budoucna.</p>
<h1>Dovedu rychle najít chybu</h1>
<p>V kombinaci verzovacího systému a testů dovedu velmi rychle odhalit, kterej kus kódu aplikaci rozbil. Stačí se vracet po commitech a pouštět znova testy. Jakmile začnou opět fungovat, vím, že jsem jeden commit před rozbitím. </p>
<h1>Závěrem </h1>
<p>Jednotkový testy nejsou všespasitelný. Spoustu věcí nemá smysl testovat a spousta věcí nejde unit testama vůbec podchytit. Ve světě testování ale určitě mají své místo. Snadno se s nima začne a začlení se do koloběhu vývoje. Je to taková nejsnazší cesta, jak začít produkovat lepší aplikace, psát čitelnější a bezpečnější kód.</p>
