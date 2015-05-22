---
layout: post
title: Ochrana proti 10minutemail
date: '2012-02-23 14:24:27'
tags:
- python
- tenminutemail
- 10minutemail
- script
- cron
- CRM
- spambox
- mailinator
---

10minutemail je známá služba pro ochranu proti spamu. Funguje tak, že
při přístupu na stránku dostanete emailovou adresu, která má životnost
10 minut. Dost na to odklikat registraci a ještě potvrdit platnost
emailu. Po 10ti minutách se email zruší. Vy jste tak obešli nutnost uvést
svůj opravdový email. Pokud jste ale provozovatel služby, která nabízí
obsah výměnou za Vaše kontakty a možnost poslat Vám sem tam newsletter,
10minutemail je Váš nepřítel.


<p>Protože nechceme v žádném případě mít u našich uživatelů
nesmyslné emaily, snažíme se vyhnout i desetiminutovým (dočasným)
schránkám. Ty mají navíc tu nevýhodu, že často mění doménu takové
schránky a nestačí tedy zablokovat jednu jedinou, je nutné hlídat, jaká
doména je aktuálně přidělována a průběžně je blokovat všechny, co
jsou aktivní. Script níže si pamatuje domény, které už viděl.
V případě, že detekuje novou doménu, odešle informaci emailem (mohl
by ji uložit třeba do databáze našeho CRM) a zapamatuje si, že tuhle už
viděl a nebude o ní dále informovat. Script pouštíme z Cronu
každé ráno. Je pak už na vkusu každého programátora, co s informací
o nové desetiminutové doméně udělá. My takové blokujeme ve
validátoru emailů, kterým ověřujeme platnost emailu ve webových
formulářích.</p>

<pre><code># -*- coding: utf-8 -*-
from pagedownloader import Downloader
from BeautifulSoup import BeautifulSoup
from mailer import Mailer
import sys
import os
import hashlib

reload(sys)
sys.setdefaultencoding('utf-8')

FROM = &quot;info@mydomain.com&quot;
TO = &quot;development@mydomain.com&quot;
SUBJECT = &quot;Nov&aacute; desetiminutov&aacute; dom&eacute;na&quot;
DISCLAIMER = &quot;(Toto je automatick&yacute; email odeslan&yacute; na z&aacute;klad&#283; monitorov&aacute;n&iacute; v&yacute;&scaron;e uveden&eacute; str&aacute;nky.)&quot;


url = &quot;http://10minutemail.com/&quot;
src = Downloader(url).get().getcontent()
bs = BeautifulSoup(src)
main = bs.find('input', {'name':'addyForm:addressSelect'})
domain = main['value'].split(&quot;@&quot;)[1].strip()
# print 'Current domain: ' + domain

DOMAINS_FILE = &quot;/var/data/tenminutedomains.txt&quot;

all_domains = &quot;&quot;
if os.path.exists(DOMAINS_FILE):
    all_domains = open(DOMAINS_FILE).read()

if(all_domains.find(domain) &lt; 0):
    # not in list of known tenminute mails
    hash_file_again = open(DOMAINS_FILE, &quot;w&quot;)
    hash_file_again.write(all_domains + domain + &quot;\n&quot;)
    hash_file_again.close()
    Mailer().send_email(FROM, TO, None, SUBJECT, 'Nov&aacute; dom&eacute;na desetiminutov&yacute;ch email&#367;: '
    + domain + &quot;\n\nv&iacute;ce viz &quot; + url + &quot;\n\n&quot; + DISCLAIMER)</code></pre>

<p>Za poslední dobu jsme vyblacklistovali tyto domény:</p>

<ul>
	<li>nwldx.com</li>

	<li>klzlk.com</li>

	<li>nepwk.com</li>

	<li>mailinator.com</li>

	<li>sharklasers.com</li>

	<li>rppkn.com</li>

	<li>spambox.us</li>
</ul>

<p>Některé z nich nepatří pod web 10minutemail.com, jejich funkce je
však stejná. A co Vaši uživatelé? Taky mají často email na některé
z uvedených domén?</p>

