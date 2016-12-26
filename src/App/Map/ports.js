var fb = require('../../services/firebase')
var mapper = require('../../services/mapper')
var audio = require('../../services/audio')

module.exports = function (ports) {
  var map
  ports.createMap.subscribe(function () {
    mapper.createMap({
      onClick: function () {
        ports.clearActiveSound.send('placeholder')
      },
      onCreated: function () {
        ports.mapReady.send(true)
      },
      onFeatureClick: function (sound) {
        ports.setActiveSound.send(sound.id)
      },
      onDoubleClick: function () {}
    }).then(function (_map) { map = _map })
  })
  ports.requestSoundData.subscribe(function () {
    fb.start().then(function (app) {
      return fb.queryDb(app, '/mapsounds')
    }).then(function (sounds) {
      ports.receiveSoundData.send(JSON.stringify(sounds))
    })
  })
  ports.renderSounds.subscribe(function (sounds) {
    mapper.renderSounds(map, JSON.parse(sounds))
  })
  ports.pauseAudio.subscribe(audio.pause)
  ports.playAudio.subscribe(function (ref) {
    fb.start().then(function (app) {
      return fb.queryStorage(app, ref)
    }).then(audio.play)
  })
}
