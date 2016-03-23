---
layout: post
title: "Jak left-pad rozbil internet (a váš build)"
date:   2016-03-05 16:34:01
tags:
  - node
  - npm
  - dependency management
image: /images/npm-logo.png
---

Jeden mikro-balíček pro node rozpoutal internetové peklo. Kde děláme chyby a jak se z nich poučit?

Dobře si prohlédněte následující řádky. Jsou jen tři a velmi jednoduché:

```js
while (str.length < length) {
  str = ' ' + str;
}
```

Co tenhle kód dělá? Odsadí text ```str``` zleva o tolik mezer, aby dostáhl celkové délky ```length```. Nejspíš byste takový vymysleli i na základní škole, po proflámované noci, před první ranní kávou.

A právě takový kousek kódu sehrál v předchozích hodinách velkou roli v node.js světě.

Onen script, jen v maličko složitější podobě ([na 17 řádek](https://github.com/azer/left-pad/blob/0e04eb4da3a99003c01392a55fa2fdb99db17641/index.js)) existoval od března 2014 v podobě balíčku [left-pad](https://www.npmjs.com/package/left-pad), dostupný přes [NPM registry](https://www.npmjs.com/) a postupně nabíral na popularitě.

![Statistika stažení](/images/left-pad/stats.png)

(Statistiky stažení balíčků poskytuje [npm-stat.com](http://npm-stat.com/charts.html?package=left-pad&author=&from=&to=2016-03-23))

## Kik ve vedlejší roli
Autor onoho balíčku left-pad, [@Azer](https://github.com/azer),  je poměrně 'plodný' a publikoval přes 250 npm balíků. Jedním z nich je i [kik](https://github.com/starters/kik). Název poněkud kolidující s [chatovací aplikací kik](http://www.kik.com/). A právě proto se na @Azera obrátil patentový právník a domáhal se odstranení balíčku, protože název porušuje jejich registrovanou známku. @Azer odmítl a právník tedy si nakonec vydupal u NPM změnu vlastníka balíčku (a možnost odstranění) sám.

## Gotta unpublish 'em all!
Taková reakce NPM [zanechala v @Azerovi pocit](https://medium.com/@azerbike/i-ve-just-liberated-my-modules-9045c06be67c#.at09fayt0), že NPM není vhodné místo pro svobodný software. A odpublikoval z něj ([npm unpublish](https://docs.npmjs.com/cli/unpublish)) všechny své balíky. Mezi nimi i populární left-pad.

## A pak se rozpoutalo peklo
Na balíčku left-pad totiž závisí balíček [line-numbers](https://www.npmjs.com/package/line-numbers). A na line-numbers závisí [Babel](https://babeljs.io/). Takže v okamžiku, kdy byl odpublikován left-pad, přestaly fungovat buildy projektů závisejících na Babelu. A že jich je!

Křik uživatelů donutil NPM k reakci:

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Hey npm users: left-pad 0.0.3 was unpublished, breaking LOTS of builds. To fix, we are un-un-publishing it at the request of the new owner.</p>&mdash; Laurie Voss (@seldo) <a href="https://twitter.com/seldo/status/712414400808755200">March 22, 2016</a></blockquote>


Mezitím i autoři mezilehlých balíků pracovali na opravách. Celá věc se tak poměrně rychle stabilizovala a buildy začaly opět fungovat.

## Zcela odkázáni na milost?
Celá tahle anabáze nádherně ukazuje, jak zranitelný systém je. Stačí rozhodnutí jednoho autora nebo křik jednoho právníka a na druhém konci světa začnou selhávat buildy projektů.

Jsme vydáni na milost balíčkovacímu systému, nad nímž nemáme žádnou kontrolu. A balíčky z něj mohou kdykoliv nenávratně zmizet. Jak z toho ven?

#### Commitujeme závislosti do repozitáře
Můžete všechny instalované závislosti verzovat spolu se svým kódem. Pak si ale zanášíte cizí kód k sobě a je nutné rebuildovat ([npm rebuild](https://docs.npmjs.com/cli/rebuild)) binární rozšíření. Máte ale věc ve svých rukou (tedy repozitáři).

#### Odkazujeme mimo NPM
Věděli jste, že můžete jako závislost uvést i git nebo Github repozitář? Dokonce i konkrétní commit, branch nebo tag? Zůstáváte tak sice stále závislí na někom jiném, ale nejde už o tak silnou centralizaci jako v případě NPM.

#### Máme vlastní mirror / proxy
Můžete si vytvořit vlastní proxy, která bude řešit jak vaše privátní balíčky, tak cachovat ty veřejné. Podívejte se třeba na [Kappa](https://github.com/krakenjs/kappa) od PayPalu nebo na [npm_lazy](http://mixu.net/npm_lazy/).

#### Nejsme závislí
Někdy je nejsnazším řešením žádnou závislost nevytvářet. Podívejte se, kam nás dovedla závislost na takové třířádkové blbosti, jako je odsazení zleva. Nedávno jsem [psal o ne-závislosti na balíku request](http://www.tomas-dvorak.cz/posts/nodejs-request-without-dependencies/). Někdy je možná snazší a bezpečnější něco opravdu naprogramovat, ne jen slepovat dokola cizí knihovny.

Mimochodem, balíček left-pad má jako nejnovější číslo verze 0.0.3 a line-numbers 0.2.0. [Semver říká](http://semver.org/#spec-item-4), že

> Major version zero (0.y.z) is for initial development. Anything may change at any time. The public API should not be considered stable.

Krom toho, samotná "knihovna" line-numbers je jen [32 řádků](https://github.com/lydell/line-numbers/blob/eb82c0c3da335fbd80111b771a6a3e38d7f63900/index.js) dlouhá. Nekupíme tak na sebe knihovny, ale cizí primitivní funkce o pár řádcích. Stojí nám to za ty problémy?


Jak řešíte problémy se závislostmi vy? Máte osvědčené metody? Commitujete závislosti zároveň se zdrojáky? Podělte se prosím v komentářích.
