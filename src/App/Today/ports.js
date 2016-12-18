var fb = require('../../services/firebase')

module.exports = function (ports) {
  ports.requestDeeds.subscribe(function () {
    fb.start().then(function (app) {
      return fb.queryDb(app, '/today')
    }).then(function (val) {
      ports.receiveDeeds.send(JSON.stringify(val))
    })
  })
}
