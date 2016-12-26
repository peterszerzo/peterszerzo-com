var db = require('../../services/db')
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
    db.get('/mapsounds').then(function (sounds) {
      ports.receiveSoundData.send(JSON.stringify(sounds))
    })
  })
  ports.renderSounds.subscribe(function (sounds) {
    mapper.renderSounds(JSON.parse(sounds))
  })
  ports.pauseAudio.subscribe(function (ref) {
    audio.stop(ref)
  })
  ports.playAudio.subscribe(function (ref) {
    db.storage(ref).then(audio.play)
  })
}
