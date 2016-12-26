var loader = require('./loader')

var FIREBASE_SCRIPT_URL = 'https://www.gstatic.com/firebasejs/3.6.1/firebase.js'
var startPromise
var config = {
  apiKey: process.env.FIREBASE_API_KEY,
  authDomain: process.env.FIREBASE_AUTH_DOMAIN,
  databaseURL: process.env.FIREBASE_DATABASE_URL,
  storageBucket: process.env.FIREBASE_STORAGE_BUCKET,
  messagingSenderId: process.env.FIREBASE_MESSAGING_SENDER_ID
}

// Use once Firebase is working

function _load () {
  return loader.script(FIREBASE_SCRIPT_URL)
}

function _start () {
  if (startPromise) {
    return startPromise
  }
  startPromise = _load().then(function () {
    var app = global.firebase.initializeApp(config)
    return Promise.resolve(app)
  })
  return startPromise
}

function _queryDb (app, ref) {
  return app.database().ref(ref).once('value').then(function (s) {
    return s.val()
  })
}

// Temporary replacements

function load () {
  return Promise.resolve(true)
}

function start () {
  var dummyApp = {}
  return load().then(function () {
    return Promise.resolve(dummyApp)
  })
}

function queryDb (app, ref) {
  return global.fetch('/api' + ref + '.json').then(function (res) {
    return res.json()
  })
}

module.exports = {
  _start: _start,
  _queryDb: _queryDb,
  start: start,
  queryDb: queryDb
}
