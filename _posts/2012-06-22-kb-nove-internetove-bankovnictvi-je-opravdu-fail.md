---
layout: post
title: ! 'KB - nové internetové bankovnictví je opravdu #fail'
date: '2012-06-22 12:55:59'
tags:
- kb
- mojebanka
- internetové bankovnictví
- ajax
- wicket
---
V neděli 17.6.2012 spustila Komerční banka novou verzi internetového bankovnictví(mojebanka). Přesto, že dnes už je 22.5.2012, pět dní po startu a čtyři dny po tom, co ve všech newsových webech proběhla zpráva o velkých problémech se spuštěním aplikace, stále funguje špatně.
Aktuálně: od 14:15 už mi bankovnictví funguje v pořádku.

<p><strong>Aktuálně: ve 14:15 22.6.2012 už mi jede bankovnictví v pořádku. Snad už je tedy vše OK (parametry systému i prohlížeče zůstaly stejné, rychlost i odezva internetového připojení také). Neprobíhá jim při prvním přihlášení nějaký dlouhotrvající přepočet?<br /></strong></p>
<p>Nová verze internetového bankovnictví je moderní, krásná, grafická, ajaxová, zakulacená a stínovaná. Vše, jen ne funkční a použitelná.</p>
<p>Nevím, koho v KB napadlo udělat nové bankovnictví jako jednu obří AJAXovou mrchu. PO zhruba 10 minutách od vyplnění cesty k certifikátu a hesla se mi zobrazila šablona stránky, kde v každém zajímavém bločku svítil nápis "načítám". Načítání probíhalo dalších zhruba 10minut.</p>
<p><img src="/images/103.png" alt="" width="500" height="240" /></p>
<p>Celé menu je ovládané javascriptem, takže dokud stránka načítá, nemůžete vlastně nic dělat. Do šablon příkazů k úhradě se mi vůbec nepovedlo během zhruba hodiny dostat. Chápu, že každá zbrusu nová aplikace trpí určitými porodními bolestmi, ale nemělo by to trvat pět dní. </p>
<p>Chvála jim patří za použití <a href="http://wicket.apache.org/">Wicketu</a>, ale to je asi tak vše. Udělat odhlašovací tlačítko JavaScriptové ale dle mého není dobrý nápad. JavaScript stojí (ehm, načítá) a odhlásit se také nejde.</p>
<p><img src="/images/104.png" alt="" width="500" height="200" /></p>
<p> </p>
<p>Ještě, že zůstal na přihlašovací stránce odkaz na <a href="https://www.mojebanka.cz/BusinessBanking/">MojeBanka Business</a>, kde se dá přihlásit a jede stará verze bankovnictví. Mohl jsem tak v klidu dokončit přenesení všech kontaktů a konfigurace trvalých příkazů do jiné banky, kam přecházím. Nemají sice bankovnictví ve stylu grafických orgií ani pobočku na každém rohu ale nesežerou tolik poplatků a zatím jim vše jede, jak má (včetně internetového bankovnictví, které je opravdu hezky čisté, jednoduché, neajaxové). Přechod od KB realizuji už delší dobu, takže problémy s bankovnictvím nejsou důvodem, spíš poslední tečkou.</p>
<p> </p>
<p>Závěrem, článek vyjadřuje moje subjektivní zkušenosti s novou verzí internetového bankovnictví KB. Přestože jsem ověřoval, že je prohlížeč i parametry sítě v pořádku (vše ostatní včetně původní verze bankovnictví v pořádku), chybu na mé straně nemohu zcela vyloučit,  netestoval jsem připojení z jiné sítě. </p>
<p> </p>
