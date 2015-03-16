---
layout: post
title: Konference Devel.cz 2013
date: '2013-03-03 21:21:34'
tags:
- devel
- javascipt
- přednáška
- velká data
- code review
---
Několik postřehů z konference, krátké hodnocení přednášek, linky na zajímavosti. Pokusil jsem se sepsat, co mě na konferenci zaujalo, doplnit odkazy na prezentace a celou akci popsat.

<h2>Daniel Steigerwald a EsteJS</h2>
<p>Máte tuny javascriptových knihoven, bojujete se závislostmi, verzemi, repozitáři? Problémy a řešení situací, se kterými jsem se nikdy nesetkal. Nemohu tedy hodnotit, co bylo a nebylo užitečné. Možná, že pokud programujete ve velkém na frontendu, mohla vás přednáška zaujmout. Odkaz na prezentaci jsem bohužel nikde nedohledal. Koukněte na <a href="http://twitter.github.com/bower/">Bower</a>, <a href="http://gruntjs.com/">Grunt</a> nebo <a href="http://component.io/">Component</a>. Tyto technologie Dan často zmiňoval a budou pravděpodobně odpovědí na problémy, které vidí okolo masivního využívání JavaScriptu a problémů se závislostmi, verzemi a balíčky.</p>
<p>Přednášející dorazil pozdě, následoval boj při připojování techniky. Slabší začátek konference. Vypadalo to dost neprofesionálně. Škoda.</p>
<h2>Vojtěch Semecký a kinohled.cz</h2>
<p>Jak rozjet jednoduchý projekt za pouhé dva týdny. Program kin v XML z placeného zdroje. Stačí transformovat data na json (aby šla zobrazit přímo v prohlížeči), udělat kolem toho trochu grafiky a html, vynechat databázi a může se jet. Mám rád jednoduché věci a web bez databáze člověk nevidí často. Dobrý nápad. Celý web je ještě kapku nedotažený, semtam se rozpadá na mobilech, ale stihlo se to v termínu. Není třeba víc dodávat, podívejte se sami: <a href="http://kinohled.cz/">kinohled.cz</a>. Reakce z publika byla poněkud vlažná, přednášející nebyl tak úplně bavič. Mě to neva, přijel jsem se především něco dozvědět.</p>
<h2>David Majda a Josef Reidinger - code reviews</h2>
<p>Code review je, když se na váš commit/opravu/software podívá někdo nezaujatý a dovede vám říct, co si o tom myslí a jestli je to OK. Jednoduchá myšlenka, která se může pěkně zkomplikovat. Až na váš commit kolega řekne, že takhle by to napsal jen idiot, těžko se budete bránit emocím. Code review přináší dostatek situací, kde jde spíš o soft skills, než znalost algoritmů. Pokud se rozhodnete dát mu šanci, dávejte si pozor na to, jak se vyjadřujete. Nebuďte osobní, hodnoťte kód a ne člověka.</p>
<p>Přednáška kvalitně připravená, měla spád a přednášející byli perfektní. Prohlédněte si <a href="https://speakerdeck.com/dmajda/code-reviews-ftw-devel-dot-cz-konference-2013">slidy z přednášky o code review</a>. </p>
<h2>Michal Illich a strojové učení</h2>
<p>Strojové učení je snazší, než bychom čekali a má mnoho použití. Michal Illich předvádí, co že to strojové učení je, jak funguje a k čemu by se mohlo hodit zrovna nám. Dobré téma, je pravda, že mě taky nikdy nenapadlo data dolovat tímto způsobem. Mám v zásobě připraveno 65 milionů obsáhlých a strukturovaných záznamů o návštěvách několika webů. Uvidím, jestli z toho dovedu vytahnout nějaké zajímavé informace.</p>
<p>Přednášející do značné míry četl to, co bylo na slidech a mluvil tak, že to člověka uspávalo. Jinak ale vše v pořádku. Slidy z přednášky <a href="http://www.slideshare.net/michalillich/prez-develcz3">tu</a>.</p>
<h2>David Grudl - Soft(ware) skills</h2>
<p>Davidova pověst ho předchází a na přednášku se tak všichni dost těšili. První po obědě, šance zapůsobit. Povídal o tom, co dělají programátoři špatně, jak štvou uživatele. Jak moc přemýšlíte nad obsahem chybových hlášek, sociálních tlačítek, rozvržení prvků na webu? Téma super, přednáška dle mého nic moc. Přednášející začal pozdě, popíjel pivo, bojoval s technikou, skončil pozdě a prezentaci nedokončil. Ať už je to jakkoli, pro mne vcelku zklamání. Ostatně, posuďte sami, jak takové softskills také mohou vypadat:</p>
<blockquote class="twitter-tweet">
<p>Heh, za čtvrt hodiny mám přednášet na <a href="https://twitter.com/search/%23develcz">#develcz</a> a jsem opilý na druhém konci Prahy. To jsou situace, které pořadatelům ale vůbec nezávidím!</p>
— David Grudl (@DavidGrudl) <a href="https://twitter.com/DavidGrudl/status/307824670135185408">March 2, 2013</a></blockquote>
<h2>Michal Špaček - Zahashovat heslo, uložit, ..., profit!</h2>
<p>Pokud se zajímáte o IT bezpečnost, nemohli jste Michala na českém internetu přehlédnout (a pokud ano, honem to napravte: <a href="https://twitter.com/spazef0rze">@spazef0rze</a>). Jak se chováte k heslům uživatelů? V jaké formě je ukládáte? Pokud na požádání pošlete heslo emailem, zaděláváte si na problém. Byli byste překvapeni, kolik uživatelů si jako login dá svůj email a heslo použije stejné, jako do onoho emailu. Nepodceňujte riziko, že zrovna vaše databáze uteče veřejně na internet. Prohlédněte si taky <a href="http://www.michalspacek.cz/prednasky/zahashovat-heslo-ulozit-profit-develcz">snímky z přednášky</a>.</p>
<h2>Patrick Zandl - Velká data</h2>
<p>Jednoznačně nejlepší přednáška dne, přestože tématicky byla nejvzdálenější. Patrick mluvil o přenosové síti, elektrárnách, obnovitelných zdrojích. Především však o tom, jak zatím nejsme schopni efektivně řídit výrobu a spotřebu, pálit elektřinu tam, kde se vyrábí. Zatímco Německo už na takových technologiích pracuje, u nás jsme stále ve stádiu, kdy se zvedne telefon a domluví se, zda přitopit pod kotlem, nebo ubrat. Do budoucna bude výzva na takových technologiích zapracovat a ukrojit část zisků ČEZu.</p>
<p>Přednášku si můžete pustit <a href="http://www.slideshare.net/tangero/velka-data-a-internet-veci">zde</a>. Bez toho senzačního výkladu okolo to ale asi nebude ono.</p>
<p> </p>
<h2>Michal Vašíček - Začínáme iOS vývoj</h2>
<p>Michal se snažil ukázat, jak je vývoj pro iOS snadný a příjemný. U mě vzbudil spíš opačný dojem. Jsem ze světa Javy a Androidí vývoj mi přišel tak nějak známý a jednoduchý. Objective-C mě vyděsilo a připomnělo studentská léta, když jsem si hrál s céčkem. Devel nástroje vypadají obdobně, přece jen jde o vývoj stejného typu software, jen ten jazyk pod tím je jiný. </p>
<p>Prezentaci si můžete projít <a href="http://www.slideshare.net/MichalVaek/zaciname-ios-vyvojsezdroji">zde</a>, Michal je na twitteru, tak třeba vám tam odpoví případné dotazy - <a href="https://twitter.com/mivasi">@mivasi</a>.</p>
<p> </p>
<h2>Martin Malý - CoffeeScript</h2>
<p>Martin mluvil o CoffeeScriptu. Jazyce postaveným nad JavaScriptem. Coffee má spoustu výhod, syntaxe připomíná třeba Python a snaží se vyřešit nepříjemnosti zanesené v samotném JavaScriptu. Pokud píšete hodně scriptů, možná vám usnadní práci, zpřehlední kód, pomůže vyřešit běžné slabiny JS a jeho programátorů. Pokud napíšete sem tam nějakou řádku JavaScriptu jako já, asi vám to nijak znatelně život neusnadní. Rozhodnutí je na vás.</p>
<p>Přednáška je k vidění <a href="http://www.slideshare.net/parallaxis/develconf-coffeescript">tady</a>. Obsahuje spoustu ukázek a příkladů. Koukněte na to, pokud s JavaScriptem přicházíte dnes a denně do styku.</p>
<p>Přednášející odvedl skvělou práci, celou dobu si udržel pozornost, publikum pobavil a zaujal. Tak to má vypadat.</p>
<h2>Ladislav Prskavec - AngularJS a Apiary.io</h2>
<p>Další přednáška z JavaScriptového světa. <a href="http://apiary.io/">Apiary</a> je online nástroj pro testování, dokumentaci a vývoj webových API. Co všechno umí a dovede budu muset zkusit, mám několik webů, na kterých API nabízím. Pomocí tohoto nástroje Ladislav ukazoval, jak se API chová a nechová a následně v Googlím <a href="http://angularjs.org/">AngularJS</a> stavěl aplikaci, která ono API používala. Angular je zřejmě vhodná knihovna, když píšete aplikaci obdobnou Gmailu. Nemohu soudit samotné nástroje, postupy a výhody jsou daleko před mými znalostmi JavaScriptu.</p>
<p>Přednášku si můžete prohlédnout <a href="http://www.slideshare.net/ladislavprskavec/devel-2013">tady</a>.</p>
<h2>Riki Fridrich - vlastní rozšíření do prohlížeče</h2>
<p>Poslední přednáška konference. Jak si napsat vlastní rozšíření do prohlížeče a usnadnit si tak v mnoha ohledech život. Není to nic těžkého, stačí lehká znalost JavaScriptu, několik copy and paste kousků kódu a rozšíření je na světě. Můžete za běhu modifikovat weby, dopisovat si funkce, které vám autoři stránek nepřipravili, skrývat, co vás otravuje. Několik ukázek rozšíření je k dispozici <a href="http://fczbkk.com/develcz2013">tady</a>. Prezentace jako taková nebyla a nebyl pro to ani důvod. Riki vše ukazoval na místě a k tomu vyprávěl. Přednáška super, zábavná, poutavá a užitečná. </p>
<p> </p>
<h2>Ke konfenci samotné</h2>
<p>Organizace byla v pořádku, stejně tak, jako zvolené místo (<a href="http://fit.cvut.cz/fakulta/kontakty">FIT - ČVUT</a>). K dispozici bylo nealko zdarma. Na oběd jsme vyrazili do hospody nedaleko školy. Asi jsme vybrali s kolegou lépe, než jiní. Oběd jsme měli za pár minut, jiní čekali jinde i hodinu. V ceně konference bylo i triko s devel motivem, vypadá pěkně (až ho vylovím z pračky, pokusím se vyfotit). Některé přednášky pro mě byly poněkud nicneříkající, některé super. To člověk čeká a asi to tak má být. Tolik různých témat nemůže zaujmout všechny stejně. Rozhodně nelituji soboty strávené na konferenci a pokud jste nebyli, příště to zkuste. Uvidíte, co řeší jiní lidé z IT. Možná vám najednou vaše problémy přestanou připadat tak komplikované, dovíte se něco nového, zjistíte, že něco děláte dobře a něco špatně.</p>
<p>Některá hodnocení konference jsou poněkud kritická (ani moje není samá chvála). Přísné hodnocení sepsal třeba <a href="http://horejsek.posterous.com/develcz-2013">Michal Hořejšek</a>.</p>
<p>Komplet stream tweetů je pod hashtagem <a href="https://twitter.com/search/realtime?q=%23develcz">#develcz</a>, web konference <a href="http://devel.cz/konference">zde</a> a několik fotek na <a href="http://www.flickr.com/photos/ozzyczech/sets/72157632894654753/">flickru</a>. Další poznámky z konference můžete číst třeba na <a href="http://www.zdrojak.cz/clanky/reportaz-z-devel-cz-konference-2013/">zdroják.cz</a>.</p>
<p>Díky přednášejícím i pořadateli za fajn devel akci.</p>
