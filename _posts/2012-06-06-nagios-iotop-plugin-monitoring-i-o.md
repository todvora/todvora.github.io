---
layout: post
title: Nagios - iotop plugin - monitoring I/O
date: '2012-06-07 10:11:20'
tags:
- nagios
- centreon
- iotop
- iostat
- ssh
- python
---
Monitorování I/O systému pomocí utility iotop a následný přenos dat do nagiosu využíváme k sledování čtení a zápisů na disk našich serverů. Slouží k hrubé představě o tom, jak systém I/O využívá. Iotop zobrazuje souhrná čísla pro čtení a zápis, ta budeme ukládat v nagiosu a zobrazovat pomocí frontendu centreon.

<p><a href="http://guichaz.free.fr/iotop/">Iotop</a> je utilita pro monitorování I/O navržená podle vzhledu a chování unixové utility <a href="http://www.unixtop.org/">top</a>. Poskytuje zjednodušený pohled na procesy, které využívají I/O a zobrazuje celková čísla pro zápis a čtení z disku (neřeší, na kterém z disků operace probíhá). Utilita tak nevystihuje, jak je využit který disk, ale spíše jak který proces masivně využívá čtení a zápisy. Zároveň poskytuje zjednodušená celková čísla pro zápis a čtení disků (<strong>Total DISK READ | Total DISK WRITE</strong>). Tyto dvě hodnoty chceme monitorovat v nagiosu.</p>
<p><img src="/images/98.png" alt="iotopu v konzoli" width="642" height="393" /></p>
<p>(Obrázek: Okno iotopu v konzoli)</p>
<p> </p>
<p>Protože se ale hodnoty <strong>Total DISK READ </strong>a<strong> Total DISK WRITE </strong>﻿mění v čase velmi značně, budeme muset data odečíst několikrát za sebou v krátkých intervalech a jejich hodnoty zprůměrovat. Počet oprakování se dá scriptu podstrčit v parametru <em>repeats.</em></p>
<p>Hodnoty převádíme na byty, aby bylo možné zachovat konzistenci dat (iotop je zobrazuje v lidsky čitelných hodnotách - například kilo a mega bytech). </p>
<p>Ted už samotný script monitorovacího pluginu:</p>
<pre class="prettyprint">#! /usr/bin/env python

import re
import sys
import getopt
import subprocess

# converts speed to Bytes
def convert(speed, units):
    if units == "B":
        return speed
    elif units == "K":
        return speed * 1024
    elif units == "M":
        return speed * 1024 * 1024


try:
    # params with default names in nagios
    # -w : warning level, in percents
    # -c : critical level, in percents
    # -repeats : repeats count
    opts, args = getopt.getopt(sys.argv[1:], "c:w:r:", [])

    # default values
    host = None
    warning_level = 10
    critical_level = 5
    repeats_count = 15

    for opt, arg in opts:
        if opt in ("-c"):
            critical_level = int(arg)
        elif opt in ("-w"):
            warning_level = int(arg)
        elif opt in ("-r"):
            repeats_count = int(arg)

    results_read = []
    results_write = []

    for iteration in range(repeats_count):
        process = subprocess.Popen('iotop -b -n 1', shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        output, errors = process.communicate()
        process.wait()

        match = re.search('Total DISK READ: (.*?) (\w+?)/s \\| Total DISK WRITE: (.*?) (\w+?)/s', output)

        speed_read = float(match.group(1))
        units_read = match.group(2)
        speed_write = float(match.group(3))
        units_write = match.group(4)

        # now i need to convert all to bits/s
        results_read.append(convert(speed_read, units_read))
        results_write.append(convert(speed_write, units_write))

    average_speed_read = int(round(float(sum(results_read) / len(results_read))))
    average_speed_write = int(round(float(sum(results_write)) / len(results_write)))

except:
    print "Unknown: " + str(sys.exc_info()[1])
    exit(3)

# default return values
return_code = 0
status_message = "OK"

if average_speed_read > warning_level or average_speed_write > warning_level:
    if average_speed_read > critical_level or average_speed_write > critical_level:
        status_message="Critical"
        return_code = 2
    else:
        status_message = "Warning"
        return_code = 1

print status_message + ", disk read: "+str(average_speed_read)+"B/s, disk write: "+str(average_speed_write)+"B/s |read="+str(average_speed_read)+"B/s;;;;write="+str(average_speed_write)+"B/s;;;;"
exit(return_code)
</pre>
<p>Script už jen jednoduše nahrajete na monitorovaný server a voláte jej například pomocí obalového pluginu <em>check_by_ssh </em>, který zajistí přístup ke vzdálenému stroji pomocí ssh. Data se sbírají do nagiosu, graf níže je pak vyrenderovaný z centreonu (grafická nadstavba nad nagiosem)</p>
<p> <img src="/images/99.png" alt="centreon graf" width="647" height="241" /></p>
<p>Takový monitoring vám pak poskytne informaci o tom, jak moc stroj zapisuje/čte. Pokud vás zajímají přesnější čísla, monitoring jednotlivých disků, zaměřte se spíše na data z <a href="http://en.wikipedia.org/wiki/Iostat">http://en.wikipedia.org/wiki/Iostat</a>. </p>
