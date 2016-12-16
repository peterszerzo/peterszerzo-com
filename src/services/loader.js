var loadPromises = {}

function script(url) {
  if (loadPromises[url]) {
    return loadPromises[url]
  }
  var loadPromise = new Promise((resolve, reject) => {
    var scriptElement = document.createElement('script')
    scriptElement.src = url
    scriptElement.type = 'text/javascript'
    scriptElement.async = 'true'
    scriptElement.onload = resolve
    scriptElement.onerror = reject
    document.head.appendChild(scriptElement)
  })
  loadPromises[url] = loadPromise
  return loadPromise
}

function style(url) {
  if (loadPromises[url]) {
    return loadPromises[url]
  }
  var loadPromise = new Promise((resolve, reject) => {
    var styleElement = document.createElement('style')
    styleElement.href = url
    styleElement.type = 'text/css'
    styleElement.rel = 'stylesheet'
    styleElement.onload = resolve
    styleElement.onerror = reject
    document.head.appendChild(styleElement)
  })
  loadPromises[url] = loadPromise
  return loadPromise
}

module.exports = {
  script: script,
  style: style
}
