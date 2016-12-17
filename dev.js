const process = require('process')
const firebaseClient = require('firebase-tools')
const WebpackDevServer = require('webpack-dev-server')
const webpack = require('webpack')

require('dotenv').load()

const webpackConfig = require('./webpack.config')

const compiler = webpack(webpackConfig)

const server = new WebpackDevServer(compiler, {
  contentBase: '/build/',
  hot: true,
  historyApiFallback: false,
  compress: true,
  proxy: {
    '**': 'http://localhost:5000'
  },
  quiet: false,
  noInfo: false,
  lazy: true,
  filename: 'index.js',
  publicPath: '/build/',
  stats: { colors: true }
})

firebaseClient.serve({
  apiKey: process.env.FIREBASE_API_KEY,
  authDomain: process.env.FIREBASE_AUTH_DOMAIN,
  databaseURL: process.env.FIREBASE_DATABASE_URL,
  storageBucket: process.env.FIREBASE_STORAGE_BUCKET,
  messagingSenderId: process.env.FIREBASE_MESSAGING_SENDER_ID
}).then(() => {
  console.log('Firebase listening at 5000.')
}).catch(err => {
  console.log(err)
})

server.listen(3000, 'localhost', () => {
  console.log('Dev server listening at 3000.')
})
