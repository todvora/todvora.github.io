---
layout: post
title: "Dear Amazon, let me fix that for you: Send to Kindle extension"
date:   2016-03-30 04:34:01
tags:
  - kindle
  - amazon
  - firefox
image: /images/kindle/kindle-logo.jpg
---

I know that company of your size and specialization could have problems to find an employee to fix your [Send to Kindle extension](https://addons.mozilla.org/en-US/firefox/addon/sendtokindle/) for Firefox. So I took the burden from you and here is a small wrap-up.


**Update 14. April 2016**: Amazon fixed the extension in version 1.0.2.76 and it should work. Details at the end of this article.


As a new owner of Kindle Paperwhite, I would like to send web articles to my new Kindle. But those official extensions are broken.

Quick search through [the reviews](https://addons.mozilla.org/en-US/firefox/addon/sendtokindle/reviews/) shows this:

- Worked great before it broke
- It stopped working at Firefox 45
- Does not work with FF 43
- Working again with FF 33
- Still not working FF 32
- Please fix - Firefox 32

You see the pattern here. Similar reviews are in Chrome store. So I just [complained on Twitter](https://twitter.com/tdvorak/status/714506218124021761) and went to do something else. But the official answer attracted my attention:

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr"><a href="https://twitter.com/tdvorak">@tdvorak</a> As we&#39;re unable to replicate the issue these reviews are showing, contacting us will help resolve account specific issues. ^LP</p>&mdash; Amazon Help (@AmazonHelp) <a href="https://twitter.com/AmazonHelp/status/714518305139265537">March 28, 2016</a></blockquote>


Hmmm... unable to replicate, account-specific. Is it really so? Let's just dive into it for a while. Starting Firefox from console reveals following error message:

```
1459224941323    addons.manager    WARN    Exception calling callback: TypeError:
Constructor XMLHttpRequest requires 'new'
(chrome://sendtokindle/content/modules/send-to-kindle.jsm:195:16) JS Stack trace:
S2K.createXMLHttpRequest@send-to-kindle.jsm:195:16
S2K.executeAjax@send-to-kindle.jsm:705:19
S2K.checkExtensionStatus@send-to-kindle.jsm:727:1
S2K.init/<@send-to-kindle.jsm:141:21
safeCall@AddonManager.jsm:179:5
makeSafe/<@AddonManager.jsm:195:25
Handler.prototype.process@Promise-backend.js:933:23
this.PromiseWalker.walkerLoop@Promise-backend.js:812:7
this.PromiseWalker.scheduleWalkerLoop/<@Promise-backend.js:746:1
```

Exception while creating XMLHttpRequest doesn't seem like an account-specific problem. This could be fun to follow and debug!

Any Firefox extension is basically just a ZIP archive with JavaScript source code inside. To view the extension's source code, follow these steps:

- Download the XPI file ([https://addons.mozilla.org/firefox/downloads/latest/399764/addon-399764-latest.xpi](https://addons.mozilla.org/firefox/downloads/latest/399764/addon-399764-latest.xpi))
- Rename it to addon-399764-latest.ZIP
- Extract it as a regular ZIP file

That's all, now we can sniff around, dig in source code and most importantly - see, what's around line 195 in ```content/modules/send-to-kindle.jsm```:

```js
/**
 * Create an XMLHttpRequest.
 * @returns {XMLHttpRequest} XHR
 */
createXMLHttpRequest: function () {
    // Hint: Need to use the XMLHttpRequest from the current window to workaround bug in FF for Windows/Unix
    //       causing the internal XHR to fail on cross-domain requests.
    return Services.wm.getMostRecentWindow("navigator:browser").XMLHttpRequest();
},
```

This matches well with the error message. There is a XMLHttpRequest to create, as expected. What every ordinary programmer does with an error message? Puts it into Google Search and looks for StackOverflow threads!

After a few minutes of clicking around, following snippet seems to be the magical formula:

```js
Components.classes["@mozilla.org/xmlextras/xmlhttprequest;1"]
       .createInstance(Components.interfaces.nsIXMLHttpRequest);    
```

Learning by doing, no mission critical software and nothing to lose. So just [copy and paste](https://twitter.com/thepracticaldev/status/705825638851149824) this line into that function and see, if it works.

To be able to install our **changed** and **unsigned** extension in Firefox, following steps are required:

- Save the changed source
- Create .ZIP archive from sources directory
- Rename it back to .XPI
- Open ```about:config``` in Firefox and locate ```xpinstall.signatures.required``` key. Switch it to ```false```.
- Install our modified extension from file
- Restart Firefox

And bingo! No error message in console, the 'K' icon automatically added to the menu bar, all buttons seem to work, articles are being send to kindle. We just fixed the mysterious, unrepeatable and account-specific bug, which prevented thousands of users from sending articles to their Kindle readers.

Following script can repeat all the necessary steps to fix and bundle the Sent-to-Kindle extension. Fixed extension is then created in your current working directory:

```sh
#!/bin/sh

FIND="Services.wm.getMostRecentWindow(\"navigator:browser\").XMLHttpRequest();"
REPLACE="Components.classes[\"@mozilla.org\/xmlextras\/xmlhttprequest;1\"].createInstance(Components.interfaces.nsIXMLHttpRequest);"

TMP=$(mktemp -d)

DIR=$(pwd)

wget https://addons.mozilla.org/firefox/downloads/latest/399764/addon-399764-latest.xpi -O $TMP/addon-399764-latest.xpi
unzip -d $TMP/addon $TMP/addon-399764-latest.xpi
sed -i "s/$FIND/$REPLACE/" $TMP/addon/content/modules/send-to-kindle.jsm
cd $TMP/addon/
zip -r  $DIR/addon-399764-latest-fixed.xpi ./*
cd $DIR
```
Feel free to copy, paste, modify, execute and share this snippet ([WTFPL licence](http://www.wtfpl.net/)).

**Seriously Amazon, was it so hard ?!**

PS: I really [tried to contact you](/downloads/amazon.pdf) (twice) before writing this post. Unfortunately without any answer.

## Update 14. April 2016
After two weeks of my blogpost Amazon released new version of the Send-to-Kindle extension. It has fixed this bug on the same line as I&nbsp;recommended to fix. They even found a nicer solution. Kudos to them!

```diff
- return Services.wm.getMostRecentWindow("navigator:browser").XMLHttpRequest();
+ return new (Services.wm.getMostRecentWindow("navigator:browser")).XMLHttpRequest();
```

The complete diff between old version 1.0.2.75 and new 1.0.2.76 is [available here](https://gist.github.com/todvora/b3afde0470b7be93e596c8a0be7af929). As you can see, there isn't much changed :-)
