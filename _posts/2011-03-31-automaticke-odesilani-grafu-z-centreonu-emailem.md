---
layout: post
title: Automatické odesílání grafů z centreonu emailem
date: '2011-03-31 08:56:36'
tags:
- centreon
- monitoring
- graf
---

Python script, který umožnuje automaticky pravidelně odesílat
přehledové grafy z monitorovacího nástroje centreon emailem.


<p><a href="http://www.centreon.com/">Centreon</a> je opensource rozhraní jako
nadstavba nad <a href="http://www.nagios.org/">Nagios</a> . Umožnuje pohodlně
naklikat konfigurační soubory centreonu a následně pak sledovat všechny
grafy. Rozhraní je ale do značné míry ajaxové a dost nepoužitelné pro
automatické zpracování. Dopsal jsem si tedy malý Python script, který se
k rozhraní umí připojit a stahnout si vybrané grafy, které následně
pošle emailem. Umožnuje to tak mít každé ráno přehled o grafech za
poslední den a vidět jak se situace mění během dne.</p>

<div style="text-align:center"><a href="/images/70.png"><img
src="/images/70.png" /></a></div>

<pre class=".prettyprint"><code>import subprocess
import sys
import os
import re
import time
import smtplib
import os
from email.MIMEMultipart import MIMEMultipart
from email.MIMEBase import MIMEBase
from email.MIMEText import MIMEText
from email.Utils import formatdate
from email import Encoders

# SCRIPT PRO STAZENI DEFINOVANYCH GRAFU Z CENTREONU A JEJICH ODESLANI EMAILEM

# cesta k tomuhle scriptu
script_path = sys.path[0]
# nastavim pracovni adresar stejny jako tenhle script, abych mohl pouzivat relativni cesty
os.chdir(script_path)

# --- ZACATEK KONFIGURACE SCRIPTU ---

# adresar, pro stazena. POZOR! pred skoncenim behu scriptu bude obsah smazan
DATA_DIR = "data/"
# cesta ke cookie souboru, provadim v nem nejake nahrady abych udrzel prihlasenou session
COOKIE_FILE = DATA_DIR + "cookie.txt"
# url na ktere sedi centreon
CENTREON_URL = "http://server/centreon"

# prihlasovaci udaje, idealne nejake read-only, guest, ...
CENTREON_LOGIN = "Admin"
CENTREON_PASSWORD = "loremipsum"

#prijemce emailu s grafy
SEND_TO = "foo@bar.com"

# slovnik obsahuje pary nazev_souboru : id_metriky_v_centreonu
# metrika grafu je ID v konfiguraci centreonu, zjisti se napriklad pri renderovani grafu z jeho url
# jako parametr metric
graphs = dict([
        ('graph1.png', 16),
        ('graph2.png', 12),
        ('graph3.png', 20),
        ('graph4.png', 14),
        ('graph5.png', 64),
        ('graph6.png', 18),
        ('graph7.png', 63)
        ])

# --- KONEC KONFIGURACE SCRIPTU ---

# pokud existuje stary soubor s cookie, smazu jej, potrebuji cisty
if os.path.exists(COOKIE_FILE):
    os.remove(COOKIE_FILE)

# provedu prihlaseni, tim se mi vytvori session cookie, kterou poslu pri pozadavku na graf
command = "wget --cookies=on  --load-cookies={0} --keep-session-cookies --save-cookies={0} \
--post-data=\"useralias={1}&password={2}&submit=Login\" --output-document={3}login.html \
{4}/index.php".format(COOKIE_FILE,CENTREON_LOGIN,CENTREON_PASSWORD,DATA_DIR,CENTREON_URL)

print command
process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
output, errors = process.communicate()
process.wait()

# nacteni obsahu cookie
cookie_file = open(COOKIE_FILE, "r").read()

# najdu v cookies tu, ktera se jmenuje PHPSESSID, musim ji predavat v url grafu
m = re.search('PHPSESSID\s+(\w+)', cookie_file)
session = m.group(1).strip()

# casove hodnoty od-do grafu, unix timestampy, rozdil je 24h
time_end = int(time.time())
time_start = int(time_end - (24 * 60 * 60))

# modifikace cookie souboru, zmenim jej tak,aby posilal session cookie, ktere nastavim platnost do
# budoucna
cookie_file_again = open(COOKIE_FILE, "w")
search_text = "FALSE    /       FALSE   0"
replace_text = "TRUE    /       FALSE   " + str(int(time.time() + 24 * 60 * 60 ))
cookie_file_again.write(cookie_file.replace(search_text, replace_text))
cookie_file_again.close()

for item in graphs:
    metric = graphs.get(item)
    # samotnym nactenim url se vygeneruje v datovem adresari obrazek grafu
    url = "{0}/include/views/graphs/generateGraphs/generateODSMetricImage.php?session_id={1}\
&cpt=1&metric={2}&end={3}&start={4}".format(CENTREON_URL, session, str(metric), str(time_end),
                                            str(time_start))

    command = "wget --cookies=on --load-cookies={0} --keep-session-cookies --save-cookies={0} \
--output-document={1}{2} '{3}'".format(COOKIE_FILE, DATA_DIR, item, url)
    process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    output, errors = process.communicate()
    process.wait()

# probehnu vsechny .png v datovem adresari, poslu je jako prilohu mejlem
files = []
dir_list=os.listdir(DATA_DIR)
for fname in dir_list:
    if fname.endswith(".png"):
        files.append(DATA_DIR + fname)

subject = "Grafy za obdobi " + time.strftime("%d.%m.%Y %H:%M:%S", time.localtime(time_start)) \
    +  " - " + time.strftime("%d.%m.%Y %H:%M:%S", time.localtime(time_end))

def send_mail(send_from, send_to, subject, text, files=[], server="localhost"):
  msg = MIMEMultipart()
  msg['From'] = send_from
  msg['To'] = send_to
  msg['Date'] = formatdate(localtime=True)
  msg['Subject'] = subject
  msg.attach( MIMEText(text) )
  for f in files:
    part = MIMEBase('image', "png")
    part.set_payload( open(f,"rb").read() )
    Encoders.encode_base64(part)
    part.add_header('Content-Disposition', 'attachment; filename="%s"' % os.path.basename(f))
    msg.attach(part)
  smtp = smtplib.SMTP(server)
  smtp.sendmail(send_from, send_to, msg.as_string())
  smtp.close()

send_mail("centreon@server.com", SEND_TO, "Grafy centreon", subject, files, server="localhost")

# uklidim po sobe datovy adresar, nic z toho co v nem je uz neni treba
dir_list=os.listdir(DATA_DIR)
for fname in dir_list:
    os.remove(DATA_DIR + fname)

# skoncim vzdy uspesne, to asi neni dobre, chtelo by to nejaky try-except
exit(0)</code></pre>

