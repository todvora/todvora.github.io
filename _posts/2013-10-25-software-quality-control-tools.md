---
layout: post
title: Software quality control tools
date: '2013-10-27 10:04:51'
tags:
- junit
- continuous integration
- QA
- testing
- bug tracking
image: http://www.tomas-dvorak.cz/images/99.png
---
In IVITERA, we deployed and configured many automated tests and monitoring to keep high quality standards. I would like to describe software and configuration that we used.

<h2>Unit tests, feature tests</h2>
<ul>
<li>Every new utility method/class, services, historical code when refactored or discovered bug in code (write test -> test failure -> repair code -> test pass). <a href="http://junit.org/">JUnit</a> run from <a href="http://maven.apache.org/">Maven</a> build process</li>
<li>Test, what make sense, not possible to cover 100% of code. Tests makes better code, better interfaces - <a href="http://www.tomas-dvorak.cz/clanky/k-cemu-dohaje-nejaky-junit-testy">http://www.tomas-dvorak.cz/clanky/k-cemu-dohaje-nejaky-junit-testy</a></li>
<li><a href="http://en.wikipedia.org/wiki/Mock_object">Mocking</a> services, database, framework - <a href="http://code.google.com/p/mockito/">mockito</a> and <a href="http://code.google.com/p/powermock/">powermock</a>. Possible to mock in pure <a href="http://groovy.codehaus.org/">Groovy</a> (see article <a href="http://www.aspectworks.com/2013/10/testovani-v-groovy">http://www.aspectworks.com/2013/10/testovani-v-groovy</a>)</li>
</ul>
<h2>Integration and system tests</h2>
<ul>
<li>Selenium and Webshots, Continuous Integration server <a href="http://www.jetbrains.com/teamcity/">Teamcity</a>, (or <a href="http://hudson-ci.org/">hudson</a>, <a href="http://jenkins-ci.org/">jenkins</a>, we used Teamcity, because we develop in <a href="http://www.jetbrains.com/idea/">IntelliJ IDE</a> -> good integration)</li>
<li>Test webservices - <a href="http://www.soapui.org/">SoapUI</a> (alternatives - <a href="http://alternativeto.net/software/soapui/">http://alternativeto.net/software/soapui/</a>)</li>
</ul>
<h2>Beta, Pilot tests, Acceptance tests</h2>
<ul>
<li>Every bigger project for customers</li>
<li>Often special version of SAP connected to devel environment</li>
<li>Test communication, firewall rules, emails, login to app, data transfer</li>
<li>Dozens of people testing process, webpages, email notifications (from thousands users in real deployment)</li>
<li><a href="http://en.wikipedia.org/wiki/Agile_software_development">Agile processes</a>, customer consultations (almost) every week, customer as a part of devel team, changes implemented immediately</li>
<li>Guacamole - <a href="http://en.wikipedia.org/wiki/HTML5">HTML5</a> <a href="http://en.wikipedia.org/wiki/Remote_Desktop_Protocol">RDP</a> gateway - <a href="http://guac-dev.org/">http://guac-dev.org/</a> - how to present developer desktop to customer via webapp (no need of client software, no problems with firewalls). Shared cursor and display</li>
<li>Good, when someone from development participate every meeting in customer company to get better idea, what customer needs and what expects</li>
</ul>
<h2>Continuous integration</h2>
<ul>
<li>Test runner - Teamcity. Connected to <a href="http://git-scm.com/">GIT</a>, every commit tested. Master branch as default, Stable branch has special set of tests - more extensive, longer, integration and system tests</li>
<li>CI knows revisions and changes, very easy to discover, which line break tests and whom to <a href="https://www.kernel.org/pub/software/scm/git/docs/git-blame.html">blame</a></li>
<li>Testing <a href="http://velocity.apache.org/">velocity</a> templates - <a href="http://code.google.com/p/velocity-validator/">http://code.google.com/p/velocity-validator/</a></li>
<li>Validation of css and js - <a href="http://www.jshint.com/">jshint</a>, <a href="http://www.tomas-dvorak.cz/clanky/jshint-a-spousteni-validace-javascriptu-z-prikazove-radky"> http://www.tomas-dvorak.cz/clanky/jshint-a-spousteni-validace-javascriptu-z-prikazove-radky </a></li>
<li>Source code analysers: <a href="http://pmd.sourceforge.net/">PMD</a> and <a href="http://checkstyle.sourceforge.net/">checkstyle</a></li>
<li>Custom checks for searching merge symbols (<<<<<<<), developer internal URLs, <a href="http://cs.wikipedia.org/wiki/Byte_order_mark">BOM</a> symbols, mixed encoding</li>
</ul>
<h2>Webshots</h2>
<ul>
<li>Our service for testing webapps in different browsers. Defined set of URLs, three different browsers (IE8, IE10, Firefox), 3 virtualized systems, Selenium server, Java application as a controller</li>
<li>First version based on <a href="http://code.google.com/p/wkhtmltopdf/">wkhtmltopdf</a> , second on real browsers controlled from <a href="http://www.seleniumhq.org/">selenium</a>. Third version rewritten from Python to Java. Result of test is web application displaying 3 screenshots at one page (same url, different browsers). After success, manual add of “OK” tag in stable branch (signal to automatic deployment that everything is prepared for deploy this night).</li>
<li>Czech, free, public service for screenshots (in time machine form): <a href="http://webshotter.com/">http://webshotter.com/</a></li>
</ul>
<div> </div>
<p><img style="display: block; margin-left: auto; margin-right: auto;" src="http://www.tomas-dvorak.cz/images/386t.png" alt="" width="350" height="316" /></p>
<p style="text-align: center;">(Schema of Webshots3 environment)</p>
<p> </p>
<p><img style="display: block; margin-left: auto; margin-right: auto;" src="http://www.tomas-dvorak.cz/images/387t.png" alt="" width="350" height="190" /></p>
<p style="text-align: center;">(Webshots results app - one URL in three different browsers)</p>
<h2>Selenium testing</h2>
<ul>
<li><a href="http://www.seleniumhq.org/">http://www.seleniumhq.org/</a></li>
<li>Run from CI server, command line tool, <a href="http://en.wikipedia.org/wiki/Xvfb">virtual framebuffer</a> and real browser (Firefox). Sets of commands, verifing page content in every step. Good for testing scenarios (add a course to database through web interface, verify that course is listed in webpage, delete course)</li>
</ul>
<div> </div>
<h2>Data for testing and development</h2>
<ul>
<li>Everyday fresh DB from production data, source code from Git. Based on <a href="http://dev.mysql.com/doc/refman/5.0/en/replication.html">MySQL replication</a> (production DB->slave), then copy of data directory for every developer (at night, separate version for every developer), script for damaging user data after import</li>
<li>Copy of data files (like images or attachments) to devel machines at night. More info about <a href="http://en.wikipedia.org/wiki/Wake-on-LAN">WOL</a>, backups and company infrastructure: <a href="http://blog.ivitera.com/pavel/it-infrastructure/backuppc-with-locking-and-wol"> http://blog.ivitera.com/pavel/it-infrastructure/backuppc-with-locking-and-wol </a> <a href="http://blog.ivitera.com/pavel/it-infrastructure/simple-centralized-wakeonlan-service"> http://blog.ivitera.com/pavel/it-infrastructure/simple-centralized-wakeonlan-service</a></li>
</ul>
<h2>User testing</h2>
<ul>
<li>Helpdesk, sales and accounting department - everyday usage of web applications. It would be good to test on real users from real world before publishing new projects (maybe like <a href="http://www.uxbooth.com/articles/the-art-of-guerilla-usability-testing/">http</a><a href="http://www.uxbooth.com/articles/the-art-of-guerilla-usability-testing/">://www.uxbooth.com/articles/the-art-of-guerilla-usability-testing/</a>)</li>
<li>Usability testing - only feedback from users. Inspiration: <a href="http://www.tomas-dvorak.cz/clanky/world-usability-day-prague-co-se-mi-libilo"> http://www.tomas-dvorak.cz/clanky/world-usability-day-prague-co-se-mi-libilo</a></li>
</ul>
<h2>Bug tracking</h2>
<ul>
<li><a href="http://flyspray.org">Flyspray</a> - web based bug tracking system (alternatives: <a href="http://www.bugzilla.org/">bugzilla</a>, <a href="http://trac.edgewall.org/">trac</a>, <a href="http://www.redmine.org/">redmine</a> and many other: <a href="http://alternativeto.net/software/flyspray/">http://alternativeto.net/software/flyspray</a>)</li>
<li>It would be good to consider another solutions - good experience from other projects - <a href="https://basecamp.com/">basecamp</a> (payed, mobile version, comfortable UI, intuitive, not only bugs - complete project life cycle, great notifications)</li>
</ul>
<h2>Monitoring infrastructure</h2>
<ul>
<li><a href="http://www.nagios.org/">Nagios</a> + <a href="http://www.centreon.com/">Centreon</a>, monitoring load, disk usage, mailserver and other typical infrastructure (and <a href="http://www.tomas-dvorak.cz/clanky/monitorovani-stavu-inkoustu-v-hp-tiskarne-pomoci-nagios">printers ink level</a>). </li>
<li>Monitoring webpages response time - plugin <a href="https://www.nagios-plugins.org/doc/man/check_http.htm">check_http</a></li>
<li>Test webpage performance, test plans, stresstesting - <a href="http://jmeter.apache.org/">Apache JMeter</a> (interesting alternative: <a href="http://gatling-tool.org/">Gatling</a>)</li>
<li>One infomail every day with important graphs - <a href="http://www.tomas-dvorak.cz/clanky/automaticke-odesilani-grafu-z-centreonu-emailem">http://www.tomas-dvorak.cz/clanky/automaticke-odesilani-grafu-z-centreonu-emailem</a></li>
<li>Free web pages monitoring service - <a href="http://www.monitor.us/en/website-monitoring">http://www.monitor.us/en/website-monitoring</a></li>
</ul>
<p> </p>
<p><img style="display: block; margin-left: auto; margin-right: auto;" src="http://www.tomas-dvorak.cz/images/99t.png" alt="" width="500" height="200" /></p>
