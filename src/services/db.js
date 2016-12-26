function get (ref) {
  return global.fetch('/api' + ref + '.json').then(function (res) {
    return res.json()
  })
}

function storage (ref) {
  return Promise.resolve('/media/' + ref)
}

module.exports = {
  get: get,
  storage: storage
}
