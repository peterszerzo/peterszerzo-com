var currentAudio

function play (url) {
  stop()
  currentAudio = new global.Audio(url)
  currentAudio.load()
  currentAudio.play()
}

function stop () {
  if (currentAudio) {
    currentAudio.pause()
    currentAudio = null
  }
}

module.exports = {
  play: play,
  stop: stop
}
