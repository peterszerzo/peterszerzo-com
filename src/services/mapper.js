var loader = require('./loader')

var MAPBOX_SCRIPT_URL = 'https://api.mapbox.com/mapbox-gl-js/v0.28.0/mapbox-gl.js'
var MAPBOX_STYLESHEET_URL = 'https://api.mapbox.com/mapbox-gl-js/v0.28.0/mapbox-gl.css'
var map

function getGeoJson (sounds) {
  return {
    type: 'FeatureCollection',
    features: sounds.map(function (sound) {
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

function load () {
  return Promise.all([
    loader.script(MAPBOX_SCRIPT_URL),
    loader.style(MAPBOX_STYLESHEET_URL)
  ])
}

function createMap (options) {
  var onClick = options.onClick
  var onDoubleClick = options.onDoubleClick
  var onCreated = options.onCreated
  var onFeatureClick = options.onFeatureClick
  return load().then(function () {
    var mapboxgl = global.mapboxgl
    mapboxgl.accessToken = process.env.MAPBOX_ACCESS_TOKEN
    map = new mapboxgl.Map({container: 'm_map', style: process.env.MAPBOX_MAP_STYLE_URL})
    map.on('load', onCreated)
    map.on('dblclick', function (e) {
      onDoubleClick(e.lngLat.lat, e.lngLat.lng)
    })
    map.on('click', function (e) {
      var feature = map.queryRenderedFeatures(e.point, {layers: ['sounds']})[0]
      if (feature) {
        onFeatureClick(feature.properties)
      } else {
        onClick(e.lngLat.lat, e.lngLat.lng)
      }
    })
    return Promise.resolve(map)
  })
}

function renderSounds (soundsObj) {
  var sounds = Object.keys(soundsObj).map(function (key) { return soundsObj[key] })
  var geoJson = getGeoJson(sounds)
  var soundsSource = map.getSource('sounds')
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
