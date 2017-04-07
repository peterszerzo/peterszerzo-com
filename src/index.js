var attachFastClick = require('fastclick')
var startApp = require('./App')

console.log('Hi, Mom!')
attachFastClick.attach(global.document.body)
startApp(document.getElementById('app'), global.localStorage)
