var fb = require('../../services/firebase')
var mapper = require('../../services/mapper')
var audio = require('../../services/audio')

module.exports = function (ports) {
  ports.createMap.subscribe(function () {
    return mapper.createMap({
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
    })
  })
  ports.requestSoundData.subscribe(function () {
    fb.start().then(function (app) {
      return fb.queryDb(app, '/mapsounds')
    }).then(function (sounds) {
      ports.receiveSoundData.send(JSON.stringify(sounds))
    })
  })
  ports.renderSounds.subscribe(function (sounds) {
    mapper.renderSounds(JSON.parse(sounds))
  })
  ports.pauseAudio.subscribe(function(ref) {
    console.log(ref)
    audio.stop(ref)
  })
  ports.playAudio.subscribe(function (ref) {
    fb.start().then(function (app) {
      return fb.queryStorage(app, ref)
    }).then(audio.play)
  })
}
