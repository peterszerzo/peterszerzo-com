var loader = require('./loader')

var MAPBOX_SCRIPT_URL = 'https://api.mapbox.com/mapbox-gl-js/v0.28.0/mapbox-gl.js'
var MAPBOX_STYLESHEET_URL = 'https://api.mapbox.com/mapbox-gl-js/v0.28.0/mapbox-gl.css'

function getGeoJson (sounds) {
  return {
    type: 'FeatureCollection',
    features: sounds.map(sound => {
      return {
        type: 'Feature',
        geometry: {
          type: 'Point',
          coordinates: [sound.lng, sound.lat]
        },
        properties: sound
      }
    })
  }
}

function load() {
  return Promise.all([
    loader.script(MAPBOX_SCRIPT_URL),
    loader.style(MAPBOX_STYLESHEET_URL)
  ])
}

function createMap ({onClick, onDoubleClick, onCreated, onFeatureClick}) {
  return load().then(function() {
    var mapboxgl = global.mapboxgl
    mapboxgl.accessToken = process.env.MAPBOX_ACCESS_TOKEN
    map = new mapboxgl.Map({container: 'm_map', style: process.env.MAPBOX_MAP_STYLE_URL})
    map.on('load', onCreated)
    map.on('dblclick', e => {
      onDoubleClick(e.lngLat.lat, e.lngLat.lng)
    })
    map.on('click', e => {
      const feature = map.queryRenderedFeatures(e.point, {layers: ['sounds']})[0]
      if (feature) {
        onFeatureClick(feature.properties)
      } else {
        onClick(e.lngLat.lat, e.lngLat.lng)
      }
    })
    return Promise.resolve(map)
  })
}

function renderSounds (map, soundsObj) {
  const sounds = Object.keys(soundsObj).map(key => soundsObj[key])
  const geoJson = getGeoJson(sounds)
  const soundsSource = map.getSource('sounds')
  if (soundsSource) {
    return soundsSource.setData(geoJson)
  }
  map.addSource('sounds', {
    type: 'geojson',
    data: geoJson
  })
  map.addLayer({
    id: 'sounds',
    source: 'sounds',
    type: 'circle',
    paint: {
      'circle-radius': 10,
      'circle-blur': 0.6,
      'circle-opacity': 0.8,
      'circle-color': '#381F73'
    }
  })
}

module.exports = {
  createMap: createMap,
  renderSounds: renderSounds
}
