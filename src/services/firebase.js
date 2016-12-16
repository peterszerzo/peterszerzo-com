var loadPromise
var startPromise

var config = {
  apiKey: process.env.FIREBASE_API_KEY,
  authDomain: process.env.FIREBASE_AUTH_DOMAIN,
  databaseURL: process.env.FIREBASE_DATABASE_URL,
  storageBucket: process.env.FIREBASE_STORAGE_BUCKET,
  messagingSenderId: process.env.FIREBASE_MESSAGING_SENDER_ID
}

function load() {
  if (loadPromise) {
    return loadPromise
  }
  loadPromise = new Promise((resolve, reject) => {
    var scriptElement = document.createElement('script')
    scriptElement.src = 'https://www.gstatic.com/firebasejs/3.6.1/firebase.js'
    scriptElement.type = 'text/javascript'
    scriptElement.async = 'true'
    scriptElement.onload = resolve
    scriptElement.onerror = reject
    document.head.appendChild(scriptElement)
  })
  return loadPromise
}

function start() {
  if (startPromise) {
    return startPromise
  }
  startPromise = load().then(() => {
    app = global.firebase.initializeApp(config)
    return Promise.resolve(app)
  })
  return startPromise
}

function queryDb(app, ref) {
  return app.database().ref(ref).once('value').then(s => s.val())
}

module.exports = {
  start: start,
  queryDb: queryDb
}