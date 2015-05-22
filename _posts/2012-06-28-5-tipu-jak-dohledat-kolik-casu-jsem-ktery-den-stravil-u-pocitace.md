---
layout: post
title: 5 tipů jak dohledat, kolik času jsem který den strávil u počítače
date: '2012-09-28 08:10:35'
tags:
- last
- uptime
- samba
- git
- svn
---
Potřebujete dohledat, kolik hodin jste seděli u počítače minulý čtvrtek nebo včera? V článku popíšu několik metod a míst, kam se podívat a co nejpřesněji určit, v kolik hodin jste který den u počítače začali a kolik bylo, když jste od něj odcházeli. Třeba proto, že potřebujete zpětně dohledat podklady pro fakturaci klientovi nebo ověřit, jestli sedí výkaz práce s realitou. Návod předpokládá v některých bodech linuxový stroj, jiné jsou shodné bez ohledu na systém.

<h2>Uptime</h2>
<p>Uptime je první z pomocníků, ale pouze pokud hledáte čas od současného spuštění počítače do přítomnosti. Ideálně jako odpověď na otázku "kolik hodin už u toho dnes sedím". Předpokladem je, že jste si počítač pustili z vypnutého stavu a během práce ho nerestartovali. Výpis z uptime vypadá nějak tak:</p>
<pre>dvorak@machine:/mnt/raid/home/dvorak$ uptime
 10:58:03 up  2:21,  4 users,  load average: 1.11, 1.15, 1.09</pre>
<p>A důležitá hodnota je to up 2:21, která říká, že dnes už sedím u počítače 2h a 21 minut.</p>
<p> </p>
<h2>Last</h2>
<p>Pokud už od onoho hledaného dne uběhla nějaká doba, uptime nám nepomůže. Last uchovává v souboru data o přihlášených uživatelích a to i zpětně (podle nastavení systému, u mě jeden měsíc).  </p>
<pre>dvorak@machine:/mnt/raid/home/dvorak$ last
dvorak   pts/2        :0.0             Thu Jun 28 10:50   still logged in   
dvorak   pts/1        :0.0             Thu Jun 28 09:41   still logged in   
dvorak   pts/0        :0.0             Thu Jun 28 08:40   still logged in   
dvorak   tty7         :0               Thu Jun 28 08:40   still logged in   
reboot   system boot  2.6.32-40-generi Thu Jun 28 08:37 - 11:02  (02:25)    
reboot   system boot  2.6.32-40-generi Thu Jun 28 00:26 - 00:45  (00:18)    
reboot   system boot  2.6.32-40-generi Wed Jun 27 20:58 - 22:24  (01:25)    
dvorak   pts/4        :0.0             Wed Jun 27 13:03 - down   (03:57)    
dvorak   pts/3        :0.0             Wed Jun 27 13:01 - down   (04:00)    
dvorak   pts/2        :0.0             Wed Jun 27 12:58 - down   (04:02)    
dvorak   pts/1        :0.0             Wed Jun 27 12:09 - 17:01  (04:51)    
dvorak   pts/0        :0.0             Wed Jun 27 12:03 - down   (04:58)    
dvorak   tty7         :0               Wed Jun 27 12:02 - down   (04:58)    
reboot   system boot  2.6.32-40-generi Wed Jun 27 11:55 - 17:01  (05:05)    
reboot   system boot  2.6.32-40-generi Wed Jun 27 00:23 - 00:41  (00:18)    
dvorak   pts/4        :0.0             Tue Jun 26 14:03 - down   (06:25)    
dvorak   pts/3        :0.0             Tue Jun 26 12:46 - down   (07:41)    
dvorak   pts/2        :0.0             Tue Jun 26 12:36 - down   (07:51)    
dvorak   pts/1        :0.0             Tue Jun 26 11:23 - down   (09:05)    
dvorak   pts/0        :0.0             Tue Jun 26 11:17 - down   (09:11)    
dvorak   tty7         :0               Tue Jun 26 11:17 - down   (09:11)    
reboot   system boot  2.6.32-40-generi Tue Jun 26 11:13 - 20:28  (09:15)    
</pre>
<p>Pokud vám stačí čas startu a zastavení počítače, všímejte si řádek reboot, pozor ale na automatické startování stroje při zálohování a pod. Pokud pracuje na jednom stroji více uživatelů, budete se muset probádat přes uživatelská jména.</p>
<p>Data bere last v souboru /var/log/wtmp (u mě na ubuntu, jinde možná jiná cesta). Zároveň mi systém drží ještě jeden odrolovaný log v gzipu /var/log/wtmp.1.gz, ten se dá rozbalit a podstrčit  příkazu last pokud budete chtít jít v historii ještě dál. A pokud pravidelně zálohujete, dovedete si soubor s daty pro last vytahnout ze zálohování a načíst.</p>
<h2>Log samby</h2>
<p>Jestli provozujete někde na serveru sambu a máte nastaveno automatické připojování síťových disků, můžete údaje o připojení a odpojení disků najít v auditních záznamech samby pod událostmi connect a disconnect. Pozor na to, že záznamy se opakují, disky mužete během dne připojit a odpojit vícekrát. Pro pátrání, kdy ráno člověk začal a kdy večer dopracoval je to ale použitelné.</p>
<pre>server:~# tail -n 1000 /var/log/samba/audit.log | grep connect | grep dvorak
Jun 26 11:05:23 server smbd[18862]: dvorak|192.168.1.32|__ffff_192.168.1.32|preklady_data|connect|ok|preklady_data 
Jun 26 11:05:23 server smbd[18862]: dvorak|192.168.1.32|__ffff_192.168.1.32|shared|connect|ok|shared 
Jun 26 11:29:40 server smbd[15667]: dvorak|192.168.1.32|__ffff_192.168.1.32|shared|connect|ok|shared 
Jun 26 11:29:40 server smbd[15668]: dvorak|192.168.1.32|__ffff_192.168.1.32|preklady_data|connect|ok|preklady_data 
Jun 26 11:29:45 server smbd[18862]: dvorak|0.0.0.0|__ffff_192.168.1.32|shared|disconnect|ok|shared 
Jun 26 11:29:45 server smbd[18862]: dvorak|0.0.0.0|__ffff_192.168.1.32|preklady_data|disconnect|ok|preklady_data 
Jun 26 21:00:58 server smbd[15667]: dvorak|192.168.1.32|__ffff_192.168.1.32|shared|disconnect|ok|shared 
Jun 26 21:00:58 server smbd[15668]: dvorak|192.168.1.32|__ffff_192.168.1.32|preklady_data|disconnect|ok|preklady_data 
Jun 26 21:02:15 server smbd[9156]: dvorak|192.168.1.32|__ffff_192.168.1.32|shared|connect|ok|shared 
Jun 26 21:02:15 server smbd[9156]: dvorak|192.168.1.32|__ffff_192.168.1.32|preklady_data|connect|ok|preklady_data 
Jun 26 22:42:23 server smbd[9156]: dvorak|192.168.1.32|__ffff_192.168.1.32|preklady_data|disconnect|ok|preklady_data 
Jun 26 22:42:23 server smbd[9156]: dvorak|192.168.1.32|__ffff_192.168.1.32|shared|disconnect|ok|shared 
</pre>
<h2>Verzovací systémy</h2>
<p>Když nelze použít žádnou z přesných metod výše, bude nutné obrátit se na nějaké méně exaktní zdroje, třeba pomohou dohledat aspoň rámcově časy.</p>
<p>Ve verzovacích systémech doporučuji prohledat čas prvního a posledního commitu pro daného uživatele a den. Pokud commitujete často a malé změny, je velká šance, že se přiblížíte k času začátku a konce pracovního dne.</p>
<h2>Odeslaná pošta</h2>
<p>Posíláte hodně mailů? Reagujete na zprávy z předchozího dne hned ráno den následující? Najděte první email který jste poslali ten den. Dost možná nebude velká prodleva mezi začátkem práce a odesláním onoho emailu.</p>
<p> <strong>Máte další tipy, jak dohledat čas ztrávený u počítače? Podělte se prosím v komentářích.</strong></p>
