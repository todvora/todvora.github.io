---
layout: post
title: "Jaká byla konference W-JAX 2015"
date:   2015-11-09 07:14:46
tags:
- java
- wjax
image: /images/wjax2015-logo.png

---
W-JAX je gigantická Java konference, která se tradičně koná v německém Mnichově. Zaměřuje se na [DACH region](http://it-slovnik.cz/pojem/dach) a většina přednášek tak probíhá v němčině. Pro představu o rozsahu konference - více než 180 přednášek, 160+ přednášejících, často běží zároveň 10 různých přednášek se zcela rozdílnými tématy. Není problém si vybrat něco zajímavého. Je problém rozhodnout se, které jiné přednášky kvůli tomu obětuji.

# Den 1. - Agile
První den je spíše rozjezdový. Workshopy běží paralelně celý den, je možné vybírat z témat jako Docker, JavaFX, úvod do JS pro Java vývojáře a dalších. Kdo raději pasivně poslouchá, může vybírat z přednášek ve velkém tanečním sále. Téma dne je agilita a většina speakrů se jej drží. Z agilních session těžko něco konkrétního poznamenat. Všichni a všechno je flexibilní, produktivní, kreativní, happy a lucky. Člověk může snadno získat dojem, že agilní metodiky dovedou spasit celý svět.

Přednáška *Behavior-driven Development in plain Java* mě tak konečně zachraňuje z bezbřehého agilního optimismu a vrací zpět do technické reality. Hodilo by se vám psát unit testy tak, aby byly výsledky čitelné i pro neprogramátory? [JGiven](http://jgiven.org/) by vám mohlo pomoci. Píšete čistý Java kód a unit test, ze kterého je následně možné vygenerovat čitelný report, který pochopí i váš šéf. Narozdíl od [JBehave](http://jbehave.org) nejste nuceni napsat scénář, který mapujete na test. Naopak váš test bude přeložen na čitelný scénář.


A od techniky zpět k abstraktnu. *Train your Brain – Google Style* je přednáška točící se okolo [Search Inside Yourself](https://siyli.org/). Meditací, sociální inteligencí a soustředěním se na nádech a výdech k lepšímu vývojáři. Pomoc, já už dál nemůžu, honem mi ukažte nějaký zdrojový kód!

Jako oáza klidu a míru na mě působí workshop *Einführung in JavaScript für Java-Entwickler*, tedy úvod do JS pro Java vývojáře. Nic nepotěší oko programátora tak, jako chybová hláška

> Uncaught TypeError: undefined is not a function

Tady je svět v pořádku (tedy záleží, jak a jestli definujete pořádek). Od úplných základů v JS se během workshopu propracujete až k úvodu do [Reactu](https://facebook.github.io/react/), [ES6](https://github.com/lukehoban/es6features) a [Webpacku](https://webpack.github.io/).

# Den 2. - reactive, big data

Druhý den zahajuje [Henk Kolk](https://jax.de/wjax2015/speakers/henk-kolk) vyprávěním o tom, jak v ING přešli od outsourcingu k vlastním vývojovým teamům (samozřejmě agilním). Okolo vývoje se prý točí celý jejich business a díky inovacím, mikroslužbám, devops teamům a agilitě dovedou méně štvát zákazníky i vývojáře a rychleji reagovat na jejich přání. Zní to skoro jako zázrak. Má někdo reálné zkušenosti a podělí se v komentářích?

Příležitostně se zajímám o Scalu a reactive programování. V rámci samostudia jsem z kurzu [Principles of Reactive Programming](https://www.coursera.org/course/reactive) znal i [Rolanda Kuhna](https://twitter.com/rolandkuhn). Jeho přednášku jsem si tak nenechal ujít. JAX rozhovor s ním na téma Reactive: [Hloupé kopírování vzorů k úspěchu nevede [DE]](https://jaxenter.de/das-stumpfe-kopieren-von-mustern-fuehrt-nicht-zum-erfolg-29621). Rozhodně doporučuji zapsat se na zmíněný kurz (zdarma). Pro vývojáře v javě nebude práce se scalou problém a reaktivní principy jsou staro-nová teorie, která je v decentralizovaném IT světě stále populárnější.

Reactive tématu se držela i přednáška *Reactive Microservices mit Vert.x*. [Vert.x](http://vertx.io/) je framework pro vytváření reaktivních aplikací nad JVM. Základem je messaging mezi jednotlivými verticles - tedy malými a ucelenými bloky aplikace. Ty mohou běžet paralelně, vzdáleně, jak je libo. Systém hodně připomíná [actors z akka](http://doc.akka.io/docs/akka/snapshot/scala/actors.html). Zajímavostí vert.x je i to, že vás nechá zvolit vlastní implementační jazyk. Ať už Javu, JavaScript, Groovy nebo Ruby.

Rozdíly a podobnosti jednotlivých technologií pak shrnula přednáška *Neue Concurrency-Modelle auf der JVM*. V hlavních rolích [quasar/fibers](http://docs.paralleluniverse.co/quasar/#fibers), [clojure/agents](http://clojure.org/agents), [vert.x/verticles](http://vertx.io/docs/vertx-core/java/#_verticles) a [akka/actors](http://doc.akka.io/docs/akka/snapshot/scala/actors.html).

Na tak velké vývojářské akci nechybělo ani IBM a jejich Bluemix. Pokud vás zajímají cloudové aplikace s umělou inteligencí, pak se podívejte na jejich [API a možnosti](https://console.ng.bluemix.net/catalog/). Využili byste třeba [klasifikaci obrázků](http://visual-recognition-demo.mybluemix.net/)?

Nejen javou je živ vývojář a není tak od věci dozvědět se, co mají všichni na tom Fluxu. Přednáška
[Flux - Příspěvek Facebooku k UI-architektuře budoucnosti [DE]](http://www.embarc.de/wp-content/uploads/2015/11/Flux.pdf) byla lehký a nenásilný úvod do Flux myšlenky. Došlo i na technologie jako je [Relay a GraphQL](https://facebook.github.io/react/blog/2015/02/20/introducing-relay-and-graphql.html).

Na přednášce *Přistání mimozemšťanů - Arquillian v praxi* jsme rychle prolétli možnosti integračního testování s [Arquillianem](http://arquillian.org). Zajímavostí může být i to, že na vývoji Arquillianu se značně podílí lidé z brněnského QA oddělení Red Hatu.

Big data den zakončila keynote *Reflexions on Big Data, Ethics, Politics and Human Rights*. Je neoddiskutovatelné, že naše data budou i nadále shromažďována, analyzována a prodávána. Jak velkou moc nad nimi máme my sami? Může ten samý dataset sloužit dobrým i zlým věcem zároveň? Jak moc jsou  anonymní data anonymizována? Takové otázky rozebírá [Data-Pop Alliance](http://datapopalliance.org/).

<div class="video">
<iframe src="https://player.vimeo.com/video/144769490" width="560" height="315" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
</div>

# Den 3. - mikroservices, integrace, legacy systémy
*The Rise of Jigsaw in JDK 9* - projekt [Jigsaw](http://openjdk.java.net/projects/jigsaw/), součást Javy 9, řeší modularitu aplikací i JDK samotného. Na úrovni zdrojových kódů, run-time i závislostí. Není od věci technologii otestovat a stále je čas zaslat své připomínky a návrhy k implementaci. Nemusíme jen čekat, co na nás s novou verzí Javy spadne. Ve vzdálenější budoucnosti (JDK 10?) pak stojí za to zmínit projekty [Panama](http://openjdk.java.net/projects/panama/) a [Valhalla](http://openjdk.java.net/projects/valhalla/).

Co by měl každý Java vývojář vědět o třídě String a optimalizacích při práci s řetězci? Je dobrý nápad volat metodu [intern()](https://docs.oracle.com/javase/8/docs/api/java/lang/String.html#intern--) nad každým řetězcem? Co je to [String Deduplication v G1 garbage collectoru](http://openjdk.java.net/jeps/192)? Pokud se rozhodnete nějakou optimalizaci naprogramovat sami, dost možná drasticky snížíte výkon. Když už stejně neodoláte, otestujte si výkon třeba v [Java Microbenchmarking Harness](http://openjdk.java.net/projects/code-tools/jmh/).

Kdy se hodí víc REST API a kdy zasílání zpráv? Jak spolu mají komunikovat ony všespasitelné microservices? Co se hodí víc pro load balancing, service discovery, event driven architekturu a mnoho dalších postřehů na slidech [REST vs. Messaging For Microservices [EN]](https://speakerdeck.com/ewolff/rest-vs-messaging-for-microservices).

Následovala keynote od SAPu na téma internet věcí. Megalomanské projekty a [velkolepá promo videa](https://www.youtube.com/watch?v=5jOzUGvD_X8) nemohou chybět. Internet věcí nejsou jen fitness náramky a senzory v mobilu, ale třeba logistika nákladních kontejnerů nebo senzory sledující opotřebení pneumatik. Tam, kde se točí peníze narazí člověk dřív nebo později i na SAP.

<div class="video">
<iframe width="560" height="315" src="https://www.youtube.com/embed/5jOzUGvD_X8" frameborder="0" allowfullscreen></iframe>
</div>

Z opačného konce jde na business Red Hat. Firma, kterou živí opensource a peníze má z podpory a služeb. K tématu DevOps předvádí svůj [Openshift](https://www.openshift.com/), žonglují s Docker kontejnery a většina prezentace je záznam z command line. Mimochodem [Openshift free plan](https://www.openshift.com/pricing/plan-comparison.html) je fajn možnost, kde hostovat na webu své nestandardní aplikace zdarma. K dispozici prostor pro 3 aplikace, nonstop provoz, 1GB uložiště, přístup přes SSH, kód v Gitu. Na hraní a pet projekty rozhodně zajímavé.

[Heinz Kabutz](https://twitter.com/heinzkabutz) je Java kouzelník, který vám na pár slidech ukáže, že vlastně o paralelismu nic moc nevíte. Deset jednoduchých ukázek, deset zákeřností, jedna vedle druhé. Podívejte se na [The Secrets of Concurrency](http://www.javaspecialists.eu/archive/Issue146.html). Co se stane, když použijete jako synchronizační objekt String? (hint: [string interning](http://www.javaspecialists.eu/archive/Issue155.html))

Dostali jste na starost letitý systém, pořádný monolit. Odstávky jsou běžné, protože každá aktualizace ovlivňuje celý systém. Nezřídka aplikace celá lehne, závislosti na cizích systémech jsou obvykle příčina pádu. Jak z toho ven? Nejprve stabilizovat, nenechat problémy druhých padat na mou hlavu. Oddělit volání cizích systémů pomocí [Hystrix](https://github.com/Netflix/Hystrix). Každé volání vzdáleného systému jde přes Hystrix. Ten monitoruje propustnost, navrací fallback hodnotu v případě neúspěchu, implementuje [circuit breaker](http://martinfowler.com/bliki/CircuitBreaker.html). Když je systém stabilní, můžete se postupně pustit do modernizování. Rozebrat na jednotlivé logické bloky (třeba maven moduly) a pokusit se z nich vytvořit mikroservices. Pro zvýšení výkonu lze sahnout po observables z [RxJava](https://github.com/ReactiveX/RxJava). Celá prezentace dostupná v angličtině na [speakerdeck](https://speakerdeck.com/holkra/legacy-systeme-mit-microservices-hystrix-und-rxjava-modernisieren).

*Rise of the Machines* - tak se jmenovala přednáška Marcuse Tandlera. Marcus je známý německý SEO specialista. Přednáška však (naštestí) nebyla o SEO, on a off-page faktorech, jak by člověk čekal. Google není firma na vyhledávání, Google je firma na umělou inteligenci. Udělejte si chvíli času a pusťte si Marcusovu [přednášku z TEDx](https://www.youtube.com/watch?v=Fa4jQIW2etI):

<div class="video">
<iframe width="560" height="315" src="https://www.youtube.com/embed/Fa4jQIW2etI" frameborder="0" allowfullscreen></iframe>
</div>

# Den 4. - Scala, Groovy, Go
Co nového ve scale? Třeba magie ve formě [maker](http://docs.scala-lang.org/overviews/macros/overview.html). Užitečné ke generování kódu, statickým kontrolám, psaní vlastního DSL ([příklady](http://www.47deg.com/blog/scala-macros-annotate-your-case-classes)).

Možná vás víc než scala zajímá [Groovy](http://www.groovy-lang.org). K čemu by se mohlo hodit? Třeba jako univerzální lepidlo nebo endoskop ([Groovy Usage Patterns](http://www.slideshare.net/gr8conf/groovy-usage-patterns-by-dierk-knig)). Groovy je dnes už mainstream a budeme se s ním setkávat častěji a častěji.
Přestože jde o dynamický jazyk, neznamená to automaticky nebezpečný. Není pro něj problém třeba statická kontrola správnosti SQL dotazu v čase kompilace ([příklad](https://github.com/Dierk/GroovyInAction/blob/68bc274db20751fcd7157fde06554b55fe883221/listings/chap10/snippet1005_SqlMainTC.groovy)). Líbí se vám Groovy ale místo JVM používáte Node.js? Pak mrkněte na [grooscript](http://grooscript.org/tutorial.html).

Request-response model je u webových aplikací často dávná minulost. Vznikají nové a moderní Single Page Aplikace. Jak takové aplikace zabezpečit? S novými technologiemi nemizí [staré známe zranitelnosti](https://www.owasp.org/index.php/Top_10_2013-Top_10). Session ID v Cookie už zdaleka nestačí a nevyhovuje novým modelům aplikací. Jeho náhradou může být třeba [JSON Web Tokens](http://jwt.io/). Data jsou zašifrovaná přímo v tokenu, nemusíte tak mít stavový backend, řešit synchronizaci sessions napříč službami a servery.

Kdo by nechtěl pracovat v inovativní firmě, na moderních projektech a přinášet ty nejlepší a nejnovější nápady. Jenže jak takové nápady prosadit a přesvědčit vedení? Řešením by mohl být třeba [SCARF model](http://it.toolbox.com/blogs/mainframe-world/managing-people-the-scarf-model-65668). Návod, jak prezentovat inovaci takovým způsobem, že ji bude moct těžko někdo odmítnout ([slidy k prezentaci](https://speakerdeck.com/jzakotnik/wjax-2015-presentation)).

Má poslední přednáška na konferenci má název *Wake me up before you go-go.* K čemu je [jazyk Go](https://golang.org/) dobrý? Jaké má stinné a světlé stránky? A je to jen vylepšené C++? Pro mě zcela neznámý svět a jazyk. Pokud potřebujete výkon, nízký overhead, obsluhovat obří množství požadavků, dejte mu šanci a projděte si [rychlý úvod na pár slidů](https://drive.google.com/file/d/0B9UHcjmhSzZoTDFhU2QwS1hNSEk/view).

# Organizace, zázemí
Konference je megalomanská nejen počtem přednášejících, ale i záběrem témat, zázemím, cateringem a v neposlední řadě bohužel i cenou. Čtyřdenní vstupné vychází na cca 1600€. Když k tomu člověk připočte hotel a dopravu, dostává se cena do závratných výšin.

O účastníky je ale vzorně postaráno. Tři patra sálů pro přednášky, stabilní internet, tablet pro včasně registrované, všechno jídlo a pití od rána do noci v ceně, předplatné pro Java magazín na rok dopředu.

Mnoho přednášek je zaznamenáno a volně k dispozici na [vimeo.com/jaxtv/videos](https://vimeo.com/jaxtv/videos)-

 PS: Hledáte zrovna novou práci a láká vás zahraničí? Stále potřebujeme v Skidata nové kolegy v oblastech Java development, QA, mobilní aplikace. Mrkněte na [nabídku otevřených pozic](http://www.skidata.com/en/career/open-positions.html) a staňte se mým kolegou. Účast na konferencích je jeden z mnoha příjemných bonusů ;)
