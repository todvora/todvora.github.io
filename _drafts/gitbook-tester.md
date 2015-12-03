---
layout: post
title: Gitbook Tester - introduction
date:   2015-12-03 18:50:16
categories:
  - publishing
  - e-book
  - integration tests
  - gitbook
image: /images/gitbook-tester/gitbook-tester.png
---

Gitbook-tester is a small wrapper and integration framework around [Gitbook](https://github.com/GitbookIO/gitbook) itself.
It tries to make integration testing as easy as possible. Just provide some content,
let gitbook-tester do its job and validate the results. Especially useful for authors of
gitbook plugins.


## But ... what is Gitbook?
Gitbook is a modern book format and toolchain using Git and Markdown. You write your
content in Markdown (or AsciiDoc) and Gitbook will build your content to a beautiful
book, PDF, E-Book, online page, whatever you need. I am using it for writing
technical documentation to software products.

## Installation
[Gitbook-tester](https://github.com/todvora/gitbook-tester) is provided as a npm module.
Simply call
```sh
npm install gitbook-tester --save-dev
```
to add it to your project and save in ```package.json``` [devDependencies](https://docs.npmjs.com/files/package.json#devdependencies).

## Basic usage
Lets say we want to test built-in plugin [emphasize](https://www.npmjs.com/package/gitbook-plugin-emphasize) to see if it does, what promises.

```js
tester.builder()
    .withContent('This text is {em}highlighted !{endem}')
    .withBookJson({"plugins": ["emphasize"]})
    .create()
    .then(function(result) {
      expect(result[0].content).toEqual('<p>This text is <span class="pg-emphasize pg-emphasize-yellow" style="">highlighted !</span></p>');
    })
```

Gitbook-tester automatically builds a book for you, gives it your content,
attaches ```book.json``` configuration, installs all required plugins and
modules. At the end, build of the book is executed. You receive results as a
[javascript promise](http://www.html5rocks.com/en/tutorials/es6/promises/).

Add some asserts or expects, pass promise down the test framework  and you are done (see [Mocha - working with promises](https://mochajs.org/#working-with-promises)). All temporary
resources will be automatically closed and cleaned for you.

## No mocks, real  tests
It would be nice to unit-test our extension to gitbook. And it's totally valid option.
Write your unit tests to test functions, utilities, classes. But at the end,
you want some certainty, that your software plays nicely with gitbook itself. You provide
some hooks or entry points and need to validate that they are called, parameters
passed and results transported back to a book. That's not something you can do by
mocking Gitbook itself. You need real integration tests and real Gitbook engine. That's where Gitbook-tester helps.

## Test your gitbook-plugin
Lets say you wrote your first Gitbook plugin. Maybe you want to wrap every image
 into [figure](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/figure) and display some caption underneath. The result could look like:

 ![Image captions](/images/gitbook-tester/caption.jpeg)

 To test that, you need to attach some image to a book, make your plugin available
 and build the book using Gitbook. Complete test could look like:

 ```js
var tester = require('gitbook-tester');
var assert = require('assert');

describe('gitbook-plugin-image-captions', function() {
  it('should create caption from alt attribute', function() {
    return tester.builder()
      .withContent('![bar](foo.jpg)')
      .withLocalPlugin(__dirname)
      .create()
      .then(function(results) {
        assert.equal(results[0].content, '<figure><img src="foo.jpg" alt="bar"><figcaption>Figure: bar</figcaption></figure>');
      });
  });
});
 ```

```Describe``` and ```it``` functions come from Mocha or Jasmine or any other
test framework you like. The real gitbook-tester work starts with ```tester.builder()```. Then you can configure your test book. We are adding some content by calling:

```js
.withContent('![bar](foo.jpg)')
```

Then we need to provide our local plugin and make it available to gitbook:
```js
.withLocalPlugin(__dirname)
```
Current script directory (in node.js available under ```__dirname```) will be attached
to the book and plugin automatically registered.

The call ```.create()``` starts the real ```gitbook build``` command. Output of the execution is a HTML format of the book. This is read and provided to our test as a promise.
Last step in our call chain is usual promise function ```then```.

```js
.then(function(results){
    // assert results
})
```

## Adapting book.json content
Your plugin has probably some configuration, that should be noted in ```book.json```.
Simply add to the build chain following call:
```js
.withBookJson(jsonObject)
```
where ```jsonObject``` is a standard javascript object like:

```json
{
  "pluginsConfig": {
    "image-captions": {
      "caption": "Image - _CAPTION_"
    }
  }
}
```

## Real world usage
[Gitbook-tester](https://github.com/todvora/gitbook-tester) is new project, but already
used in several gitbook core plugins:

- [empatize](https://github.com/GitbookIO/plugin-emphasize/blob/master/test/index.js)
- [superscript](https://github.com/GitbookIO/plugin-superscript/blob/master/test/index.js)
- [image-captions](https://github.com/todvora/gitbook-plugin-image-captions/blob/master/spec/tests_spec.js)

Use those projects as a additional guide and source of copy-paste tests :-)
