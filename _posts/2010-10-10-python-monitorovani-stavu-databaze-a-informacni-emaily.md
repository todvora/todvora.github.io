---
layout: post
title: ! 'Python: monitorování stavu databáze a informační emaily'
date: '2010-10-10 16:42:55'
tags:
- databáze
- python
---

Jednoduchý script, který je cyklicky spouštěn z cronu, zjistí stav
databáze, najde podezřele dlouho běžící dotazy a odešle je emailem.


<pre class="prettyprint"><code>import MySQLdb
import sys
import smtplib
from email.MIMEText import MIMEText
import getopt


# v mysql by mel existovat uzivatel, ktery ma pravo na sledovani procesu a nic vic.
# GRANT PROCESS ON *.* TO 'server-monitor'@'localhost' IDENTIFIED BY 'password';

# cas v sekundach jako limit pro dlouhobezici query
MAX_TIME = 300
# jen vypsat hodnoty, zadne odesilani emailu, mejly se posilaji, pro debug vystup pridat
# parametr -p
PRINT = False

# pristupove udaje k databazi
host = "localhost"
username = "server-monitor"
password = "password"

# konfigurace mailove komunikace
FROM = "server@domain.com"
TO = "admin@domain.com"
SUBJECT = "Sledovani stavu MySQL"
SERVER = "localhost"

# vzorova data v resultu
# (245L, 'root', 'localhost', None, 'Query', 7L, None, 'SHOW FULL PROCESSLIST')

# definice id jednotlivych sloupcu resultu
ID_PROCESS_ID = 0
ID_USER = 1
ID_HOST = 2
ID_DB = 3
ID_COMMAND_TYPE = 4
ID_TIME = 5
ID_STATE = 6
ID_QUERY = 7

# pokusim se naparsovat parametry, hledam jaky maximalni cas je pro povolenou query
try:
    opts, args = getopt.getopt(sys.argv[1:], "t:p", ["time=","print"])
except getopt.GetoptError:
    print "Error: Unable to read program parameters!"
    print sys.exc_info()[1]
    exit(2)

for opt, arg in opts:
    if opt in ("-t", "--time"):
        MAX_TIME = int(arg)
    elif opt in ("-p", "--print"):
        PRINT = True

try:
    if(len(password) > 0):
        conn = MySQLdb.connect(host = host, user = username, passwd = password)
    else:
        conn = MySQLdb.connect(host = host, user = username)
except:
    print "Error: Unable to connect to database server!"
    print sys.exc_info()[1]
    exit(2)

cursor=conn.cursor()
cursor.execute("SHOW FULL PROCESSLIST")
result = cursor.fetchall()

# list vsech nalezenych dotazu splnujicich podminku v cyklu nize
response = []

# iteruji pres vsechny procesy, ty co jsou query a starsi nez MAX_TIME a ty co neobsahuji SQL_NO_CACHE
# klauzuli, u takovych predpokladam ze je to backup databaze a ten muze bezet dloooouho.
for record in result:
    if(record[ID_COMMAND_TYPE] == "Query") and (record[ID_TIME] > MAX_TIME):
        response.append(record)

if(len(response) > 0):
    response.insert(0, "(processID, user, host, db, type, time, state, query)")
    if(PRINT):
        print str(response)
    else:
        # pokud jsem nalezl, vlozim do seznamu jeste hlavicku
        msg = MIMEText(str(response))
        msg["Subject"] = SUBJECT
        msg["To"] = TO
        s = smtplib.SMTP()
        s.connect(SERVER)
        s.sendmail(FROM, TO, msg.as_string())
        s.close()
        exit(1)
else:
    exit(0)</code></pre>

