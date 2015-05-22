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


<pre><code>#! /usr/bin/env python

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
    opts, args = getopt.getopt(sys.argv[1:], &quot;H:c:w:&quot;, [&quot;host=&quot;])

    # default values
    host = None
    warning_level = 10
    critical_level = 5

    for opt, arg in opts:
        if opt in (&quot;-H&quot;, &quot;--host&quot;):
            host = arg
        elif opt in (&quot;-c&quot;):
            critical_level = int(arg)
        elif opt in (&quot;-w&quot;):
            warning_level = int(arg)

    # get url content, somewhere insite it are defined javascript values with ink levels
    conn = urllib2.urlopen(&quot;http://&quot; + host + &quot;/index.htm?cat=info&amp;page=printerInfo&quot;) # get the url
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
    print &quot;Unknown: &quot; + str(sys.exc_info()[1])
    exit(3)

# default return values
return_code = 0
status_message = &quot;OK&quot;
if (cyan &lt; warning_level) or (magenta &lt; warning_level) or (yellow &lt; warning_level)\
    or (black &lt; warning_level):
    if (cyan &lt; critical_level) or (magenta &lt; critical_level) or (yellow &lt; critical_level)\
     or (black &lt; critical_level):
        status_message=&quot;Critical&quot;
        return_code = 2
    else:
        status_message = &quot;Warning&quot;
        return_code = 1

# Nagios standard output, human readable text | performance data
print status_message + &quot;: Toner level cyan: &quot; + str(cyan) + &quot;% magenta: &quot;+ str(magenta)\
 + &quot;%, yellow: &quot;+ str(yellow) + &quot;%, black: &quot; + str(black) + &quot;% |cyan=&quot;+str(cyan)+\
 &quot;%;;;;&quot;+&quot;magenta=&quot;+str(magenta)+&quot;%;;;;&quot;+&quot;yellow=&quot;+str(yellow)+&quot;%;;;;&quot;+&quot;black=&quot;+str(black)+&quot;%;;;;&quot;
exit(return_code)</code></pre>

