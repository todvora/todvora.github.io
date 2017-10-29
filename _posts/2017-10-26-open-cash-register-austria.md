---
layout: post
title: "Open solution for cash registers in Austria"
date:   2017-10-26 08:00:00
tags:
  - opensource
  - linux
  - pos printer
  - QRK

image: /images/cashdesk/msi-flex-allinone.png
---

Do you have to deal with laws and technical requirements of cash registers in Austria? It's a nightmare, surrounded by closed solutions, [vendor lock-ins](https://en.wikipedia.org/wiki/Vendor_lock-in), exorbitantly high prices, monthly payments and hardware offers you will regret sooner or later. But there is a combination, which is open source, modular, runs on your hardware, doesn't require internet connection and does not send all your business data to someone else's cloud. Let me introduce it to you.

## What's wrong with existing solutions?
Imagine you are starting a small business in Austria and searching for a simple cash register solution. It looks really simple on all introduction videos. You just need a tablet, order a printer, few clicks online and you are good to go. Right? Let's get together through a minefield of usual existing solutions, explaining what's wrong with them.

### Hardware: tablet
Buy any cheap Android tablet, connect it to the internet, install our app and done. That's what they say. A cheap Android tablet, connected nonstop to the internet, dealing with all your business data. This is a huge red flag.  

Android tablets are notoriously known for their security vulnerabilities and poor updates distribution from manufacturers. There is a chance that your tablet will be outdated in the moment you buy it. And if not, you can't expect any updates after year or two. Almost all manufacturers see it as a consumer good - use it, throw it away after it breaks down, looks old and is terribly slow. This isn't a business segment - you are buying a toy.

It may be a little bit better with Apple devices, which get updates for much longer period. But it's still a toy, only in 400€+ range. And you are still very limited in applications you can run, printers you can connect to it.

### Cloud solution: connection
Cloud means that all your data are sitting on someone else's server. Probably not secured well (even the biggest and best companies lose data sometimes). All your data is flowing through the internet. So there is a chance that someone will be able to read the data, delete them, modify or simply sell to anyone who is interested. We don't have to be that negative, maybe there is no hacker and the provider company simply bankrupts. But you have to keep all your data for at least 7 years. Maybe they give you time to migrate to another solution and download all historical data. But, who knows?

Additionally, all the simple tablet solutions do always require internet connection. They need it to communicate, they need it to sign the data. But this is an additional 20€+ monthly cost. So at least 250€ / year to the bill. Do not forget that.

### Cloud solution: price
You can check some prices on [registrierkassen-test.info](http://registrierkassen-test.info/gesamtliste-registrierkassen/). They are usually somewhere between 20 and 50€ / month. You can find several for 5€ or 9€, sometimes with an "activation fee" of 100€ or such. This all means at least 100-500€ payment yearly.

### Cloud solution: free (almost)
But what about those free of charge solutions in the list, like [Kassa24](www.kassa24.at/) or [helloCash](https://hellocash.at)? What's wrong with them? Usually, **when you are not paying, you are not customer - you are the product.** So expect their advertising on your receipts, expect offerings to upgrade to a paid plan, count with very limited support. Kassa24, for example, promises availability of 99,5% on their free plan. This corresponds to a daily outage of 7m 12s, weekly 50m 24s, monthly 3h 39min.

And there can be some additional, hidden costs as well. HelloCash states that the price is without a required certificate in price of 30€ / year (wait, what's that?!).

> exklusive des gesetzlich erforderlichen Zertifikats iHv. € 29,90 netto pro Jahr ([hellocash.at/preise](https://hellocash.at/preise))

### POS printers
With an Android or iPad solution, you are quite limited in selection of available POS printers. Not that it would be technically impossible, but the providers of cash register solutions like simple answers, tested and compatible products and they assume what's right for you.

Basically, when you want to use a tablet solution, they will offer you a small, tiny tiny blue-tooth printer designed to be portable. Battery powered, with a small roll of paper, on a belt clip. Is that really what you need in your store? Not mentioning that such a portable solutions is usually more expensive, more complicated.

Epson even provides a SDK (software development kit) for Android, so any cash register could theoretically support many models from Epson.  But the cash register companies haven't choose that way. The offer you one of only three models on their webshop, nothing else works and is not supported.

> Wir bieten nur die Drucker an, die wir aufgelistet haben. Es funktionieren keine anderen Drucker! (technical support of [Kassandro.at](http://kassandro.at/#pricePlans))

I imagine a simple, everywhere available, reliable printer like [Epson TM-T20II](https://www.epson.eu/products/sd/pos-printer/epson-tm-t20ii-series). It costs some 130€, you can get it in the nearest computer shop, it's dead simple. If it breaks down, you can get immediately a replacement.

The situation is similar to, let's say, Audi, forcing you to select from three different types of tyres. Two summer tyre types, one winter. Your car will not work with any other tyre, even with the same specification, exact size and parameters. Good luck with that.

### Professional, all in one solutions
Now you are in a 1500€+ range. And vendor lock-in area. You get a blackbox, sometimes based on an Android or Windows tablet, with pre-installed software and printer. You are now completely dependent on what the provider gives you and what supports. And if you need one piece of cash register, you are probably not very lucrative customer to them. They will not prepare functions just to make you happy. Take it or leave it.

## What I would like to have
Now, when I described what is wrong with usual solutions, let's focus on finding a good and open solution. So, what I really wanted and needed for a small [coffeehouse of my girlfriend](https://www.i-cafe.at/):

- Be in charge of system updates and have an up-to-date system in the future
- Range of POS printers supported (easily replaceable)
- Offline-first approach, not to be dependent on internet connection
- A touch-screen the input device
- Simple user interface, groups of products, buttons for products, print, done

### Hardware: all in one PC
Let's start with the hardware. If you want an up-to-date system, you should avoid tablets. They will be, sooner or later, left behind by any manufacturer and you can throw them away. But there is quite similar looking group of devices, called All-In-One PC. To name some - [MSI Flex](https://at.msi.com/All-in-One-PC/AP16-Flex.html) or [ASUS Pro AIO](https://www.asus.com/All-in-One-PCs/A4110/). They look like a bulky tablets, have standard PC components, can run any operating system, have a variety of ports and connectors. With prices starting at 350€ we are still in a range of more expensive tablets, but with a powerful solution prepared for any peripherals (think barcode scanner) or printers. They come with an integrated stand, look good, won't be a target of thieves (what would they do with it, unlike iPad).

![MSI Flex](/images/cashdesk/msi-flex-allinone.png)  
(Image source: [at.msi.com](https://at.msi.com/All-in-One-PC/AP16-Flex.html))

I have selected the MSI Flex and the only aesthetical detail I don't like is that the USB ports are only on the right side of the screen, not from bottom. But this would be the same for many tablets I guess.

### Operating system: Ubuntu
Now if we have an usual PC hardware, we can install any operating system. So be it Linux, any flavor you like :-) Free, open-source, updated, customizable. You can't do anything wrong with Ubuntu, as it supports well touch screens and gets regular updates. But I believe that you could choose Windows and get similar results. It depends mainly on your skills, habits and preferences.

### Printer: Epson TM20-II
Since we have a real OS, real ports (not just [USB OTG](https://en.wikipedia.org/wiki/USB_On-The-Go), shared with a power supply), local network and everything, what a real PC can provide, we can install any printer we like. Be it the Epson TM20-II with a USB port, cheap A4 laser printer, historical dot matrix printer or a shared network printer. We can even have several printers for different occasions. If you don't print too many receipts each day, maybe you can simply use your regular A4 office printer. It will work. Everything, which has a driver for your OS can be used.

I used the Epson TM20-II POS printer over USB ([linux driver](https://download.epson-biz.com/modules/pos/index.php?page=single_soft&cid=5012&pcat=3&scat=32)). You can get one on Amazon, in Metro or everywhere else. As a backup, there is a Samsung laser printer used for other office tasks.

![Epson TM-T20II printer](/images/cashdesk/epson-tm-t20ii.jpg)  
(Image source: [epson.de](https://www.epson.de/products/sd/pos-printer/epson-tm-t20ii))

The printer is really fast and works well under Ubuntu. It has even a connector for a money drawer, so you can open the drawer when print starts or finishes.

### Cash register software: QRK Registrier Kasse
I do love open-source software. So when I discovered [QRK Registrier Kasse](http://www.ckvsoft.at/was-ist-das/), I couldn't be more happy. Open source, offline, conforms all required laws and technical details, good documentation. So this is my choice for small business and I believe it should work for any type of small store, cafe, hairdresser, florist shop, you name it.

![QRK Logo](/images/cashdesk/qrk.png)  
(Image source: [QRK on SourceForge](https://sourceforge.net/projects/qrk-registrier-kasse/))

The interface is simple, clean and easy to use. You enter products and their groups, define printer and receipt details, configure the smart card and register your cash register online on [FinanzOnline](https://finanzonline.bmf.gv.at/fon/) and you are done, first customer can be served.

It works well with a touch screen under Ubuntu (Onboard), which is displayed automatically when text input is needed. Usually, you don't need this when working with the cash register, there are buttons for each action.

Data are stored locally, signed by the smart card, you can configure location for external backups. Receipt printing is super fast, it allows you to select any system configured printer.

QRK supports Linux, Windows and Mac, so you can run it on almost anything, even your laptop if you serve only small amount of customers. Automatic updates are available, for Ubuntu as a [PPA repository](http://www.ckvsoft.at/knowledgebase/installation-linux/). Interesting experiment could be to run it on a Raspberry Pi with a touch screen attached.

This is the most important piece of puzzle. You could still connect your computer to the internet and use any of the web-based solutions, with remote signing and cloud storage. But the QRK cash-desk saves you money and preserves your privacy. And if you need, you can pay a programmer to write an extension or change parts of the system. It's open source, so you can have it fully under your control.

Your data is stored locally, so you have to take care of backups. And you can run it on an encrypted hard drive, which adds another layer of security.  

### Smart card and card reader: A-trust
To be able to locally sign receipts, you need to have a signature smart card and a card reader. You can easily order them from [a-trust.at](https://www.a-trust.at/webshop/). The delivery is quite fast, under two days here in Austria in my case.

![Signature card and a card reader](/images/cashdesk/smartcard.jpg)  
(Image source: author, own work)

Select [a.sign RK CHIP - Selbstaktivierung](https://www.a-trust.at/webshop/Detail.aspx?ProdId=3029) which is empty and needs to be pre-configured before usage. This is a simple additional step where you run an app, fill in some details like UID and store the cerficate to the card (works under Linux without problems). You can pay 8€ more and get the card pre-cofigured to your UID number, but I would expect somehow slower delivery in that case.  

A-Trust offers two types of card readers, either [Gemalto USB-Stick](https://www.a-trust.at/webshop/Detail.aspx?ProdId=2023) or [Gemalto IDBridge CT40](https://www.a-trust.at/webshop/Detail.aspx?ProdId=2024). Both should work the same, both supported under linux, so it's mainly about the design and form.

### Cash drawer: Safescan SD-3540
To make the whole solution complete and professional, a cash drawer is required. Luckily, there is not much you can do wrong. Either it's fully separated and manually controlled or you have the RJ12 cable which connects it to a printer and opens the drawer automatically.

![Safescan SD-3540 Standard-duty](/images/cashdesk/safescan-sd-3540.jpg)  
(Image source: [safescan.com](https://www.safescan.com/de/store/kassenladen/safescan-sd-3540-kassenlade))

I find [Safescan SD-3540 Standard-duty](https://www.safescan.com/de-at/store/kassenladen/safescan-sd-3540-kassenlade) a good and unexpensive drawer which will work fine for most usages. You can even select a smaller or light duty versions (tested for 500 000 openings), which will be cheaper.  

### Summary

Here is a rather short list of costs:

* All in one PC: 350€
* Epson printer: 130€
* Smart-card + Reader: 40€
* Cash drawer: 100€
* QRK software: free ([contribution welcomed](http://www.ckvsoft.at/unterstuetzen-sie-die-qrk-entwickler/))

So you can have a really good solution for 620€ including tax, ready to be extended (barcode reader) if you need. You can simply replace the POS printer without any troubles, you can use different computer, external keyboard, remote desktop, anything.

You are now responsible for updates and backups, but you have it all under your control. There is not a single dependency to any company, supplier or internet connection. No monthly fees, no additional hidden costs.

The QRK software is open source and their authors are not paid from licenses or fees. So if you decide to use it, consider also sending them [a reasonable donation](http://www.ckvsoft.at/unterstuetzen-sie-die-qrk-entwickler/). Especially, if you see how much troubles and money they save you.  

### Disclaimer:
I am not anyhow related to any of mentioned products, companies and software solutions. But feel free to ask me anything on this topic and please do support open solutions by using it, by donations, by writing and telling people that there are better ways how to deal with a typically business domain as cash desks are.
