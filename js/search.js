window.searcher = null;

var loadData = function(callback) {
  var xhr = new XMLHttpRequest();
  xhr.open('GET', encodeURI('/js/search_data.json'));
  xhr.onload = function() {
    if (xhr.status === 200) {
      callback(null, JSON.parse(xhr.responseText));
    } else {
      callback('Request failed.  Returned status of ' + xhr.status, null);
    }
  };
  xhr.send();
}

var getSearcher = function(callback) {
  if (window.searcher !== null) {
    callback(window.searcher)
  } else {
    window.searcher = {};
    window.searcher.idx = lunr(function() {
      this.field('title', {
        boost: 10
      })
      this.field('url');
      this.field('content');
      this.ref('url');
    });

    loadData(function(err, documents) {
      if (err != null) {
        console.log(err);
      } else {
        documents.forEach(function(doc) {
          window.searcher.idx.add(doc);
        });
        window.searcher.documents = documents;
        callback(window.searcher);
      }
    });
  }
};

var formatOneResult = function(doc) {
  var article = document.createElement('div');

  var link = document.createElement('a');
  link.setAttribute('href', doc.url);
  link.appendChild(document.createTextNode(doc.title));

  var dateSpan = document.createElement('small');
  dateSpan.appendChild(document.createTextNode(doc.date));

  var excerpt = document.createElement('p');
  excerpt.appendChild(document.createTextNode(doc.excerpt))

  article.appendChild(link);
  article.appendChild(dateSpan);
  article.appendChild(excerpt);

  return article;
};

var formatNoResults = function() {
    var result = document.createElement('div');
    var message = document.createElement('p');
    message.appendChild(document.createTextNode('No posts matched your search. Please try again.'))
    result.appendChild(message);
    return result;
}

document.getElementById('searchform').addEventListener('submit', function(e) {
  e.preventDefault();

  var list = document.getElementById('results');

  while (list.firstChild) {
    list.removeChild(list.firstChild);
  }
  list.classList.add('loader');

  var query = document.getElementById('query').value;

  getSearcher(function(searcher) {

    var found = searcher.idx.search(query);

    var docfrag = document.createDocumentFragment();
    if(found.length > 0) {
      found.forEach(function(item) {
        var completeDoc = searcher.documents.filter(function(doc) {
          return doc.url == item.ref
        });
        completeDoc.forEach(function(toRender) {
          docfrag.appendChild(formatOneResult(toRender));
        });
      });
    } else {
        docfrag.appendChild(formatNoResults());
    }

    list.classList.remove('loader');
    list.appendChild(docfrag);
  });
});
