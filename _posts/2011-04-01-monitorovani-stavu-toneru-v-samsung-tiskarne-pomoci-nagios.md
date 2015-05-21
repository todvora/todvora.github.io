---
layout: post
title: Monitorování stavu toneru v Samsung tiskárně pomocí nagios
date: '2011-04-01 17:12:34'
tags:
- samsung
- python
- nagios
- monitoring
---

Pokud ve firmě provozujete monitorování serverů a síťových
zařízení, určitě by bylo vhodné doplnit i monitorování stavu
tiskáren. Jeden z pohledů na tiskárnu je množství toneru, kterým
ještě disponuje. Napíšeme si tedy nagios plugin pro monitorování
množství toneru v tiskárně Samsung SCX-4×28 Series.


<p>Kód níže představuje jedoduchý script v jazyce Python, který
monitoruje stav tiskárny Samsung SCX-4×28 Series a výsledky měření
předává ve formátu pro <a href="http://www.nagios.org/">Nagios</a>
monitorovací systém. Obdobný script, jen pro tiskárnu HP jsem popisoval již
dříve: <a
href="/posts/monitorovani-stavu-inkoustu-v-hp-tiskarne-pomoci-nagios">Monitorování stavu inkoustu v HP tiskárně pomocí nagios</a></p>

<p><img src="/images/71.gif" alt="Samsung SCX-4×28 Series" />
<br />Ilustrační obrázek tiskárny Samsung SCX-4×28 Series</p>

<hr />

<pre class=".prettyprint"><code>#! /usr/bin/env python

import urllib2
import re
import sys
import getopt

# timeout in seconds pro nacteni stranky
timeout = 10
urllib2.socket.setdefaulttimeout(timeout)

try:
    opts, args = getopt.getopt(sys.argv[1:], "H:c:w:", ["host="])

    host = None
    warning_level = 10
    critical_level = 5

    for opt, arg in opts:
        if opt in ("-H", "--host"):
            host = arg
        elif opt in ("-c"):
            critical_level = int(arg)
        elif opt in ("-w"):
            warning_level = int(arg)

    conn = urllib2.urlopen("http://" + host + "/Information/supplies_status.htm") # get the url
    src = conn.read() # read page contents
    # hledam retezec ve tvaru: var BlackTonerPer = 92;
    m = re.search('var\s+BlackTonerPer\s+=\s+(\d+)', src)
    toner = int(m.group(1))
    # http://nagiosplug.sourceforge.net/developer-guidelines.html#AEN33
except:
    print "Unknown: " + str(sys.exc_info()[1])
    exit(3)

return_code = 0
status_message = "OK"
if toner < warning_level:
    if toner < critical_level:
        status_message="Critical"
        return_code = 2
    else:
        status_message = "Warning"
        return_code = 1

return_message = status_message + ": Black toner level: " + str(toner) + "%|black="+str(toner
)+"%;"+str(warning_level) + ";" + str(critical_level) + ";;"
print return_message
exit(return_code)</code></pre>

<hr />

<p><img
src="/images/72.png" alt="stav inkoustu" />
<br />Screenshot z webového rozhraní, které ukazuje stav inkoustu</p>

<p><img
src="/images/73.png" alt="centreon monitoring" />
<br />Graf z Centreonu, který získává data výše popsaným pluginem
pro Nagios</p>

