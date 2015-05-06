---
layout: post
title: Forpsi a plaintextová hesla
date: '2013-07-11 20:36:58'
tags:
- bezpečnost
- forpsi
- hesla
---
Ukládat hesla v plaintextu a na vyžádání je zasílat nezměněná emailem, to chce pořádnou dávku odvahy. Nebo to není odvaha, ale úplně jiná vlastnost? 

<p>Kdykoliv vám provozovatel služby zašle vaše zapomenuté původní heslo e-mailem, mějte se na pozoru. Jestli jej dovede zjistit a zaslat, dovede to každý, kdo má přístup k jeho systémům. Zaměstnanci, dodavatelé, hackeři, člověk, co našel v odpadcích záložní disk...</p>
<p>Pokud taková firma, <a href="http://forpsi.org/">cituji</a>, "patří k největším poskytovatelům internetových služeb na českém trhu", je třeba být obzvláště opatrný.</p>
<h2>Máte domény, hosting, servery u Forpsi? Nepotěším vás</h2>
<p>Forpsi zasílá <a href="http://www.forpsi.com/getpwd.php">zapomenuté heslo</a> obyčejným emailem, nezměněné, původní. Neukládají hash, jako každý aspoň trochu rozumný. A na kritiku pro jistotu nijak nereagují a problém neřeší (moje tweety z <a href="https://twitter.com/tdvorak/status/312630776850161664">15.3</a>, <a href="https://twitter.com/tdvorak/status/352650049655816192">4.7.</a>, <a href="http://www.tomas-dvorak.cz/images/332.png">e-mail 11.7</a>)</p>
<p> </p>
<p><img src="http://www.tomas-dvorak.cz/images/331t.png" alt="Forpsi plaintext heslo" width="648" height="288" /></p>
<p> </p>
<p> </p>
<p>Když pomineme to, že poslat heslo mailem není zrovna košer, mnohem větší problém je to, že posílají vaše původní, nezměněné heslo. Znají ho, mají ho tak někde čitelně uložené, čekající na to, až uteče do veřejné části internetu. </p>
<h2>Jak je to správně</h2>
<p>Pokud si nejste jisti, co je a není dobře, projděte si třeba prezentaci <a href="https://twitter.com/spazef0rze">Michala Špačka</a> z devel konference: <a href="http://www.slideshare.net/spaze/hashe-hesla-develcz-2013">http://www.slideshare.net/spaze/hashe-hesla-develcz-2013</a></p>
<p>Hash hesla sám o sobě není nic extra bezpečného. Ale plaintextově uložené heslo, to je jen otázka času, kdy přijde opravdu velký průser.</p>
<p> </p>
<h2>Disclaimer </h2>
<p>Článek nenabádá k žádným útokům na společnost, snažím se jen upozornit na problém, který jsem zaznamenal. A protože mě Forpsi ignoruje, doufám, že je tímhle textem postrčím k opravě.</p>
<p>Takže, pěkně prosím, vyjádří se někdo kompetentní, proč tomu tak je a zda je v plánu oprava? </p>
<p> </p>
