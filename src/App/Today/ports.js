module.exports = function (ports) {
  ports.requestDeeds.subscribe(function () {
    ports.receiveDeeds.send(JSON.stringify({}))
  })
}
