---
layout: post
title: Utilita pro parsování webového rozhraní Selenium Gridu
date: '2011-03-15 20:22:02'
tags:
- python
- selenium
- grid
---

Jednoduchá python utilitka, která rozumí webovému rozhraní Selenium
Gridu a umí vrátit stroje dostupné v jednotlivých sekcích: Configured,
Available a Active. Hodí se pro automatické startování dalších runnerů,
případně k jinému automatizovnému přístupu ke Gridu


<div><a href="/images/69.png"><img
src="/images/69.png" alt="selenium grid screenshot" /></a></div>

<pre><code># -*- coding: utf-8 -*-

# Utilitka pro parsovani uvodni stranky selenium-grid hubu, ktera rozumi jednotlivym sekcim a je
# podle parametru schopna najit tu spravnou sekci a predat data pro dalsi zpracovani (grep, wc, ..)

from BeautifulSoup import BeautifulSoup,SoupStrainer
import sys
import urllib2
import getopt

# timeout in seconds
timeout = 10
urllib2.socket.setdefaulttimeout(timeout)

sections = &quot;configured,available,active&quot;

try:
    opts, args = getopt.getopt(sys.argv[1:], &quot;s:&quot;, [&quot;sections=&quot;])
except getopt.GetoptError:
    print &quot;Error: Unable to read program parameters!&quot;
    print sys.exc_info()[1]
    exit(2)

for opt, arg in opts:
    if opt in (&quot;-s&quot;, &quot;--sections&quot;):
        sections = arg

def printsection(section):
    for tr in section:
        rows = []
        for td in tr.findAll(&quot;td&quot;):
            rows.append(td.string)
        print ' '.join(rows)

the_page = &quot;&quot;
downloaded = False
download_counter = 0
while not(downloaded) and download_counter &lt; 30:
    try:
        req = urllib2.Request(&quot;http://orion:4444/console&quot;)
        response = urllib2.urlopen(req)
        the_page = response.read()
        downloaded = True
    except KeyboardInterrupt:
        print &quot;You hit control-c, exiting&quot;
        exit(1)
    except:
        print sys.exc_info()[1]
        sys.stdout.flush()
    download_counter = download_counter + 1

html = the_page.encode(&quot;utf-8&quot;)
bs = BeautifulSoup(html)
sections_html = bs.findAll('div', {&quot;class&quot;:&quot;section&quot;})

configured = sections_html[0].findAll('tr')[1:]
available = sections_html[1].findAll('tr')[1:]
active = sections_html[2].findAll('tr')[1:]

if(sections.find('configured') &gt; -1):
    printsection(configured)

if(sections.find('available') &gt; -1):
    printsection(available)

if(sections.find('active') &gt; -1):
    printsection(active)</code></pre>

<p><strong>Výstup:</strong></p>

<pre><code>python utils/grid_sections.py -s available
    demeter.insite.cz 5766 IE9proxy
    forest.insite.cz 5566 *iexploreproxy
    localhost 5555 *chrome

python utils/grid_sections.py -s configured
    *firefox3 *firefox3
    Safari on OS X *safari
    *chrome *chrome
    *firefox2 *firefox2
    *firefoxproxy *firefoxproxy
    *pifirefox *pifirefox
    Firefox on Windows *firefox
    *iehta *iehta
    *piiexplore *piiexplore
    *iexploreproxy *iexploreproxy
    IE9proxy *iexploreproxy
    *opera *opera
    Firefox on OS X *firefox
    *safariproxy *safariproxy
    *firefox *firefox
    *safari *safari
    *iexplore *iexplore
    *googlechrome *googlechrome
    Firefox on Linux *firefox
    IE on Windows *iehta</code></pre>

