require('./styles.compiled.css')
var attachFastClick = require('fastclick')
var app = require('./App')

console.log('Hi, Mom!')
attachFastClick.attach(document.body)
app()
