var db = require('../../services/db')

module.exports = function (ports) {
  ports.requestDeeds.subscribe(function () {
    db.get('/today').then(function (val) {
      ports.receiveDeeds.send(JSON.stringify(val))
    })
  })
}
