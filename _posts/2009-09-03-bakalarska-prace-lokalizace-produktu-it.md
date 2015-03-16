---
layout: post
title: Bakalářská práce - lokalizace produktů IT
date: '2009-09-03 17:30:46'
tags:
- bakalářská práce
- zču
---

Krátký popis mé bakalářské práce


<h2>Úvod</h2>

<p style="text-align:justify">Má bakalářská práce je zaměřena na
navržení kompletního systému pro lokalizaci softwarového produktu,
seznámení s jednotlivými aspekty lokalizace, problémy při lokalizaci a
jejich řešení. Rozebírá standardní řešení a vysvětluje proč je
navržené a implementované řešení pro konkrétní situaci lepší.
<br />Lokalizaci produktu musí přecházet internacionalizace, tedy upravení
produktu, především jeho zdrojových kódů, souborů s nápovědou a
dokumentací do stavu, kdy je od sebe oddělen zdrojový kód a informace,
které budou lokalizovány. Následuje lokalizace, kdy jsou zdrojové texty
překládány do konkrétních jazyků, upravováno uživatelské nastavení,
jako je směr písma, tvar výpisu data, měny, procent, adresy a mnoho
dalších aspektů. To vše již bez zásahu do zdrojových kódů aplikace.
<br />Po lokalizaci nutně následuje testování a korekce k zajištění
kvality finálního produktu. V následujících řádkách bych chtěl
poskytnout přehled o celém lokalizačním procesu. Také bych chtěl
přiblížit jednotlivé principy fungování lokalizačních nástrojů a
programů. Po přečtení této práce by měl mít každý dostatečný
přehled o tom, co je lokalizace, jaké jsou postupy při lokalizaci a
umět lokalizovat vlastní projekt.</p>

<h2>Závěr</h2>

<p style="text-align:justify">Cílem této práce bylo nabídnout současné
trendy v lokalizaci IT produktů. Zaměřil jsem se na produkty
společností Google a Microsoft, jako největších firem v oblasti
internetu a stolních počítačů. Obě společnosti nabízejí nástroje pro
strojový překlad textu v různých situacích. Popsal jsem tedy tyto
nástroje a jejich použití. Dále jsem se věnoval lokalizaci obecně,
lokalizačnímu procesu z pohledu samotného návrhu a časovému
rozložení projektu lokalizace. Tato část práce by měla posloužit jako
seznam kroků a jejich vhodný sled při vývoji softwaru, který bude
lokalizován.
<br />Podrobněji je rozebráno použití Gettextu. Gettext je nástroj pro
lokalizaci zdrojových kódů, především PHP a jazyka C. Práce s ním
je velmi snadná a přehledná. Druhý nástroj popsaný v teoretické
části je OmegaT. OmegaT je software s otevřeným zdrojovým kódem,
podobně jako Gettext. Zaměřuje se však na překlad jiného spektra zdrojů.
Jde především o HTML stránky, texty dokumentace, obsah psaný pomocí
textových editorů, jako je MS Word nebo OpenOffice Writer. Umožňuje však
samozřejmě překládat i texty použité právě Gettextem.
<br />V druhé části práce jsem zvolil k lokalizaci svůj vlastní
projekt Záložky. Záložky jsou webová aplikace umožnující uživatelům
přidávat odkazy na internetové stránky, sdílet a komentovat tyto odkazy
s ostatními registrovanými uživateli. Lokalizaci tohoto projektu jsem se
rozhodl implementovat pomocí jazyka Java a jím nabízených lokalizačních
postupů. Značná část těchto postupů však nesplňovala moje požadavky na
správu lokalizovaných textů a možnosti jejich ukládání, proto jsem
patřičné postupy programoval sám. Jednalo se především o ukládání
překladů v databázi, jejich automatické načtení do uživatelského
rozhraní v okamžiku, kdy existuje novější verze překladů a celková
dynamika práce s lokalizovanými texty. Vytvořil jsem webové rozhraní
ke slovníku a editaci překladů.
<br />Lokalizace splnila má očekávání na rychlost a dynamiku. Je však
nutné počítat s tím, že v mé aplikaci je lokalizováno pouze
několik desítek řetězců. Při opravdovém nasazení na projektu většího
rozsahu by bylo zřejmě nutné upustit od některých konkrétních aspektů,
jako je automatická aktualizace překladů celé aplikace po změně překladu.
Případně přistoupit k vygenerování jazykových variant pro každou
stránku.</p>

<h2>Ke stažení</h2>

<p><a href="/file_download/39"
title="Bakalářská práce - Lokalizace produktů IT - Tomáš Dvořák">bakalarska_pra­ce_tomas_dvorak­.pdf</a></p>

