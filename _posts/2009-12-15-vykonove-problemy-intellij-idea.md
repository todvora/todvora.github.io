---
layout: post
title: Výkonnostní problémy Intellij Idea
date: '2009-12-20 14:34:01'
tags:
- java
- ide
- idea
- linux
---

Na ubuntu jsem poslední dobou zaznamenal značné problémy s výkonem
aplikace idea od intellij. Článek obsahuje návod jak je odstranit.


<p>Popisované chování jsem zaznamenal na ubuntu 9.10, čtyřjádrovém
intelu, 4GB paměti a zhruba 500GB místa na disku. Stroj docela výkonný na
to, aby utáhl jedno IDE. Přitom při stejné konfiguraci na předchozí verzi
ubuntu vše fungovalo jak má. Velmi špatně se chovalo například
scrollování při skocích mezi metodami a vůbec práce s okny a
editorem. Následně jsem na jeden rozdíl našel. Jsou jím proprietární
ovladače grafické karty nvidia, které jsem předtím nepoužíval. Po chvíli
hledání jsem narazil na řešení. Chybu způsobuje EXA akcelerace. Stačí
editovat soubor idea.vmoptions a přidat do něj řádek</p>

<p><strong><code>-Dsun.java2d.pmoffscreen=false</code></strong></p>

<p>Náhle běží idea vzorně a problémy přestaly. Pokud se potýkáte
s podobnými komplikacemi, zkuste to.</p>

<p>A kde jsem na to přišel: <a
href="http://www.cs.bgu.ac.il/~gwiener/programming/how-to-make-intellij-idea-8-usable-on-linux/">http://www.cs.bgu.ac.il/~gwiener/programming/how-to-make-intellij-idea-8-usable-on-linux/</a></p>

