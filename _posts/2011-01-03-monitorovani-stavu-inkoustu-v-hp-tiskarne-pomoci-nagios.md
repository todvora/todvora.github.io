---
layout: post
title: Monitorování stavu inkoustu v HP tiskárně pomocí nagios
date: '2011-01-03 19:26:24'
tags:
- nagios
- hp
- monitoring
---

Kratičký plugin do nagiosu na monitorování stavu inkoustu v HP
tiskárnách s webovým rozhraním


<pre class="prettyprint"><code>#! /usr/bin/env python

import urllib2
import re
import sys
import getopt

# Monitor ink level in HP printers, works on HP Officejet Pro L7700
# see http://nagiosplug.sourceforge.net/developer-guidelines.html#AEN33

# page read timeout in seconds
timeout = 10
urllib2.socket.setdefaulttimeout(timeout)

try:
    # params with default names in nagios
    # -H, --host : ip address of printer
    # -w : warning level, in percents
    # -c : critical level, in percents
    opts, args = getopt.getopt(sys.argv[1:], "H:c:w:", ["host="])

    # default values
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

    # get url content, somewhere insite it are defined javascript values with ink levels
    conn = urllib2.urlopen("http://" + host + "/index.htm?cat=info&page=printerInfo") # get the url
    src = conn.read()

    # parse values out of page
    m = re.search('var\s+cyanink=(\d+)', src)
    cyan = int(m.group(1))
    m = re.search('var\s+magentaink=(\d+)', src)
    magenta = int(m.group(1))
    m = re.search('var\s+yellowink=(\d+)', src)
    yellow = int(m.group(1))
    m = re.search('var\s+blackink=(\d+)', src)
    black = int(m.group(1))

except:
    print "Unknown: " + str(sys.exc_info()[1])
    exit(3)

# default return values
return_code = 0
status_message = "OK"
if (cyan < warning_level) or (magenta < warning_level) or (yellow < warning_level)\
    or (black < warning_level):
    if (cyan < critical_level) or (magenta < critical_level) or (yellow < critical_level)\
     or (black < critical_level):
        status_message="Critical"
        return_code = 2
    else:
        status_message = "Warning"
        return_code = 1

# Nagios standard output, human readable text | performance data
print status_message + ": Toner level cyan: " + str(cyan) + "% magenta: "+ str(magenta)\
 + "%, yellow: "+ str(yellow) + "%, black: " + str(black) + "% |cyan="+str(cyan)+\
 "%;;;;"+"magenta="+str(magenta)+"%;;;;"+"yellow="+str(yellow)+"%;;;;"+"black="+str(black)+"%;;;;"
exit(return_code)</code></pre>

