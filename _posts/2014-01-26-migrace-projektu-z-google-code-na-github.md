---
layout: post
title: Migrace projektu z Google Code na Github
date: '2014-01-26 16:36:50'
tags:
- github
- google-code
- git
---
Máte z nějakých historických důvodů své projekty na Google code a raději byste je přesunuli na Github? Jde to snadněji, než bych čekal.

<p> </p>
<h2>Vytvoření repozitáře na Githubu</h2>
<p>Pokud na Githubu dosud nemáte účet, nejprve se <a href="https://github.com/">zaregistrujte</a>. </p>
<p>Přihlášeni přejděte na stránku <a href="https://github.com/new">https://github.com/new</a> a vytvořte nový repozitář. Klidně ať se jmenuje stejně jako projekt na Google Code. V mém případě to je <a href="https://github.com/todvora/velocity-validator">velocity-validator</a>.</p>
<p>Volbu "Initialize this repository with a README" nezapínejte, potřebujeme čistý repozitář bez commitů.</p>
<h2>Import Google Code projektu</h2>
<p>K importu z Google Code SVN repozitáře našeho projektu využijeme <a href="https://www.kernel.org/pub/software/scm/git/docs/git-svn.html">svn2git</a>, který je obsažen ve standardní distribuci <a href="http://git-scm.com/">Gitu</a>.</p>
<p>Já importuji svůj Google Code projekt <a href="https://code.google.com/p/velocity-validator/">velocity-validator</a>, obecný příkaz je:</p>
<p><code class="prettyprint">git svn clone --stdlayout https://projectname.googlecode.com/svn projectname</code></p>
<p>a pro můj projekt pak konkrétně:</p>
<p><code class="prettyprint">git svn clone --stdlayout https://velocity-validator.googlecode.com/svn velocity-validator </code></p>
<p>Můžeme zkontrolovat, že se vše naimportovalo v pořádku, třeba výpisem posledních commitů:</p>
<p><code class="prettyprint">git log</code></p>
<h2>Push na Github</h2>
<p>Vstoupíme do naklonovaného repozitáře:</p>
<p><code class="prettyprint">cd velocity-validator</code></p>
<p>Povíme Gitu, že má pushovat na Github:</p>
<p><code class="prettyprint">git remote add origin git@github.com:GITHUB_USERNAME/REPO_NAME.git</code></p>
<p>Pro mě konkrétně tedy:</p>
<p><code class="prettyprint">git remote add origin git@github.com:todvora/velocity-validator.git</code></p>
<p>A nakonec samotný push</p>
<p><code class="prettyprint">git push origin master</code></p>
<p> </p>
<p>Nyní by veškeré změny měly být vidět na Githubu. Asi by bylo fajn napsat na úvodku projektu u Google Code, že další vývoj probíhá na Githubu. </p>
<p>Pokud máte nestandardní rozložení repozitáře, raději mrkněte na další podrobnosti migrace:</p>
<p><a href="https://code.google.com/p/support/wiki/ConvertingSvnToGit">https://code.google.com/p/support/wiki/ConvertingSvnToGit</a></p>
<p><a href="https://help.github.com/articles/importing-from-subversion">https://help.github.com/articles/importing-from-subversion</a></p>
