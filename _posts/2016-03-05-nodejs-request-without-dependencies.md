---
layout: post
title: "How to get node.js HTTP request promise without a single dependency"
date:   2016-03-05 04:34:01
tags:
  - node.js
  - request
  - npm
  - promise
  - dependencies
image: /images/david_dependencies_badge.png
---

Sometimes one needs just to read a body of simple HTTP(S) GET response, without any complicated logic and dozens of NPM dependencies involved. So why not to use all the goodies node.js core provides us.

```js
const getContent = function(url) {
  // return new pending promise
  return new Promise((resolve, reject) => {
    // select http or https module, depending on reqested url
    const lib = url.startsWith('https') ? require('https') : require('http');
    const request = lib.get(url, (response) => {
      // handle http errors
      if (response.statusCode < 200 || response.statusCode > 299) {
         reject(new Error('Failed to load page, status code: ' + response.statusCode));
       }
      // temporary data holder
      const body = [];
      // on every content chunk, push it to the data array
      response.on('data', (chunk) => body.push(chunk));
      // we are done, resolve promise with those joined chunks
      response.on('end', () => resolve(body.join('')));
    });
    // handle connection errors of the request
    request.on('error', (err) => reject(err))
    })
};
```

There is not a single external dependency included. Usage is then rather simple, due to [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise) interface:

```js
getContent('https://www.random.org/integers/?num=1&min=1&max=100&col=1&base=10&format=plain&rnd=new')
  .then((html) => console.log(html))
  .catch((err) => console.error(err));
```

Sure, we have no body parsing, no JSON validation, no encoding conversion. But do you need it anyway?

The typical recommended solution includes frequently [request package](https://www.npmjs.com/package/request). Have you ever seen the dependencies tree of this?

![Request dependencies graph](/images/request_dependencies.png)
Source: [david-dm.org/request/request](https://david-dm.org/request/request#info=dependencies&view=tree)

There were 32 new releases of request package in 2015. Are you ready to update your project every time one of those dependencies discovers a security vulnerability and forces the whole tree to release new versions? Or would you rather use the standard library for such a simple task?

Of course, if you have much more complicated requirements, dozens of dependencies already included, maybe you should just add [request-promise](https://www.npmjs.com/package/request-promise) and let it do its job:

```js
var rp = require('request-promise');
rp('http://www.google.com')
    .then((html) => console.log(html)) // Process html...
    .catch((err) => console.error(err)); // Crawling failed...
```

But before you do that, think how to keep things simple.
