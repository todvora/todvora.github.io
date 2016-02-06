---
layout: post
title: Načítání metadat z icecast audio streamu
date: '2011-08-11 10:43:35'
tags:
- python
- stream
- icecast
- metadata
---

Icecast je free streamovací audio server, který využívají některá internetová rádia. Podíváme se, jak je možné získávat informaci o tom, jaký song zrovna hraje a kdo je jeho autorem. Využijeme k tomu jednoduchý Python script.

Icecast na sebe prozrazuje informace podle hlaviček HTTP požadavků. Je tedy nutné vyslat požadavek ve správném formátu, na který icecast vrátí informace opět v hlavičkách + audio stream, ze kterého budeme číst text.

V požadavku musíme předat hlavičku **Icy-Metadata** s hodnotou **1**. Na to nám server odpoví tak ,že v hlavičče najdeme číslo, které značí, po kolika bytech streamu se nachází textové informace. Hlavička se jmenuje **icy-metaint**. Pokud tedy otevřeme stream a posuneme se na danou pozici, čeká nás byte, který informuje o tom, jak dlouhá textová informace se ve streamu nachází. Tu vynásobíme 16ti a pokud ze streamu načteme blok v tomto intervalu, získáme kýžená metadata. Byte s délkou metadat běžně bývá 0, v takovém případě se na té pozici metadata nenachází a je nutné počkat na další výskyt.

Metadata vypadají například takto:

```
StreamTitle='Blondie - One Way Or Another';StreamUrl='http://www.bandit.no';
```

Kde středníkem jsou odděleny jednotlivé informace ve tvaru Klíč=‚hodnota‘.

Nás zajímá klíč StreamTitle, který nese autora a název písně (zřejmě záleží na typu streamu, je nutné ozkoušet). Proto jej regulárním výrazem vytahneme z metadat a vypíšeme i s časem nalezení. Vypisovat budeme jen pokud se text změní s dalším songem, protože metadata se ve streamu vyskytují v různé hustotě a často se opakují v rámci jednoho songu. Celý script vypadá takto:

```py
import urllib2
import sys
import io
import time
from time import strftime,localtime
import re

reload(sys)
sys.setdefaultencoding('utf-8')

req = urllib2.Request("http://mms-live.online.no:80/p4_bandit")
req.add_header("Icy-Metadata", 1)
stream = urllib2.urlopen(req)
byteinterval = int(stream.info().get("icy-metaint"))
last_text = ""
while(stream.read(byteinterval)):
    length = ord(stream.read(1)) * 16
    text = stream.read(length)
    if(length > 0 and text != last_text):
        last_text = text
        m = re.search('StreamTitle=\'(.*?)\';', text)
        title = m.group(1)
        if(len(title.strip()) > 0):
            print title + " (" + strftime("%H:%M:%S", localtime()) + ")"
```

a výstupem může být například

```
Motorpsycho - Walkin' With J. (11:16:03)
The Clash - Lost In The Supermarked (11:16:04)
Sheryl Crow - Leaving Las Vegas (11:19:56)
Ash - End Of The World (11:26:36)
Deep Purple - Hush (11:30:36)
Bon Jovi - Livin' On A Prayer (11:35:18)
Badfinger - Day After Day (11:38:37)
Elvis Presley - A Little Less Conversation (11:41:56)
Lenny Kravitz - Are You Gonna Go My Way (11:43:16)
Queen - You're My Best Friend (11:47:16)
The Raconteurs - Many Shades Of Black (11:52:37)
Oasis - She's Electric (11:56:38)
Bob Dylan - It's Alright Ma (I'm Only Bleeding) (12:00:37)
Led Zeppelin - I Can't Quit You Baby (12:07:58)
ZZ Top - Sharp Dressed Man (12:12:58)
G. Love And Special Sauce - Baby's Got Sauce (12:16:38)
The Kooks - Ooh La (12:20:38)
Allman Brothers - Don't Keep Me Wonderin' (12:23:59)
Muddy Waters - Mannish Boy (12:27:18)
Ben Harper/The Innocent Criminals - Steal My Kisses (12:35:19)
Santana - Europa (12:39:19)
Pretenders - Back On The Chain Gang (12:43:59)
Jeff Beck - I Ain't Superstitious (12:47:59)
David Bowie - Golden Years (12:52:39)
Duncan Sheik - Barely Breathing (12:56:39)
Thin Lizzy - The Boys Are Back In Town (13:00:39)
Marc Bolan/& T. Rex - Metal Guru (13:07:19)
Bryan Adams - Summer Of '69 (13:09:58)
Poison - Unskinny Bop (13:13:08)
My Chemical Romance - Welcome To The Black Parade (13:17:10)
Bob Marley - No Woman, No Cry (13:21:49)
Blues Traveler - Run Around (13:25:50)
Orson - Ain't No Party (13:31:50)
Wild Cherry - Play That Funky Music (13:35:09)
Van Halen - Panama (13:39:50)
```

Kde je uveden klíč StreamTitle a v závorce čas, ve kterém jsme poprvé tato metadata načetli (v podstatě začátek songu).

Tento postup byl testován na norském rádiu [Bandit](http://www.bandit.no), které hraje světový rock a dá se poslouchat v podstatě pořád ;)
