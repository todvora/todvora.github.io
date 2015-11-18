---
---
window.searcher = null

escapeHtml = (str) ->
  div = document.createElement('div')
  div.appendChild document.createTextNode(str)
  div.innerHTML

decodeHtml = (text) ->
  div = document.createElement('div')
  div.innerHTML = text
  if 'textContent' of div then div.textContent else div.innerText

loadData = (callback) ->
  xhr = new XMLHttpRequest
  xhr.open 'GET', encodeURI('/js/search_data.json')

  xhr.onload = ->
    if xhr.status == 200
      callback null, JSON.parse(xhr.responseText)
    else
      callback 'Request failed.  Returned status of ' + xhr.status, null

  xhr.send()
  return

getSearcher = (callback) ->
  if window.searcher != null
    callback window.searcher
  else
    window.searcher = {}
    window.searcher.idx = lunr(->
      @field 'title', boost: 10
      @field 'tags', boost: 5
      @field 'url'
      @field 'content'
      @ref 'url'
    )
    loadData (err, documents) ->
      if err != null
        console.log err
      else
        documents.forEach (doc) ->
          window.searcher.idx.add doc

        window.searcher.documents = documents
        callback window.searcher

formatOneResult = (doc) ->
  article = document.createElement('div')
  link = document.createElement('a')
  link.setAttribute 'href', doc.url
  link.appendChild document.createTextNode(decodeHtml(doc.title))
  dateSpan = document.createElement('small')
  dateSpan.appendChild document.createTextNode(doc.date)
  tags = document.createElement('small')
  tags.appendChild document.createTextNode(doc.tags)
  tags.classList.add 'tags'
  excerpt = document.createElement('p')
  excerpt.appendChild document.createTextNode(doc.excerpt)
  article.appendChild link
  article.appendChild excerpt
  article.appendChild dateSpan
  article.appendChild tags
  article

formatNoResults = ->
  result = document.createElement('div')
  message = document.createElement('p')
  message.appendChild document.createTextNode('No posts matched your search. Please try again.')
  result.appendChild message
  result

searchFor = (query) ->
  list = document.getElementById('results')
  while list.firstChild
    list.removeChild list.firstChild
  list.classList.add 'loader'
  getSearcher (searcher) ->
    found = searcher.idx.search(query)
    docfrag = document.createDocumentFragment()
    if found.length > 0
      found.forEach (item) ->
        completeDoc = searcher.documents.filter((doc) ->
          doc.url == item.ref
        )
        completeDoc.forEach (toRender) ->
          docfrag.appendChild formatOneResult(toRender)
    else
      docfrag.appendChild formatNoResults()
    list.classList.remove 'loader'
    list.appendChild docfrag

document.getElementById('searchform').addEventListener 'submit', (e) ->
  e.preventDefault()
  query = document.getElementById('query').value
  window.location.hash = '#' + encodeURIComponent(query)
  searchFor query

if window.location.hash
  hash = window.location.hash.substring(1)
  safeValue = escapeHtml(decodeURIComponent(hash))
  document.getElementById('query').value = safeValue
  searchFor safeValue
