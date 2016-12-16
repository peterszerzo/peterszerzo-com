'use strict'

const path = require('path')
const webpack = require('webpack')
const postCssCssNext = require('postcss-cssnext')
const validate = require('webpack-validator')
const HtmlWebpackPlugin = require('html-webpack-plugin')
const FaviconsWebpackPlugin = require('favicons-webpack-plugin')
const ExtractTextWebpackPlugin = require('extract-text-webpack-plugin')

require('dotenv').load()

const commonPlugins = [
  new webpack.DefinePlugin({
    'process.env.FIREBASE_API_KEY': `"${process.env.FIREBASE_API_KEY}"`,
    'process.env.FIREBASE_AUTH_DOMAIN': `"${process.env.FIREBASE_AUTH_DOMAIN}"`,
    'process.env.FIREBASE_DATABASE_URL': `"${process.env.FIREBASE_DATABASE_URL}"`,
    'process.env.FIREBASE_STORAGE_BUCKET': `"${process.env.FIREBASE_STORAGE_BUCKET}"`,
    'process.env.FIREBASE_MESSAGING_SENDER_ID': `"${process.env.FIREBASE_MESSAGING_SENDER_ID}"`,
    'process.env.MAPBOX_ACCESS_TOKEN': `"${process.env.MAPBOX_ACCESS_TOKEN}"`,
    'process.env.MAPBOX_MAP_STYLE_URL': `"${process.env.MAPBOX_MAP_STYLE_URL}"`
  }),
  new HtmlWebpackPlugin({
    template: './src/index.pug',
    inject: true,
    hash: true
  }),
  new HtmlWebpackPlugin({
    filename: '200.html',
    template: './src/index.pug',
    inject: true,
    hash: true
  }),
  new FaviconsWebpackPlugin({
    logo: './src/images/peter-szerzo-180-2x.jpg',
    inject: true
  }),
  new ExtractTextWebpackPlugin('styles.css')
]

const config = {
  entry: [
    './src/index.js'
  ],
  output: {
    path: path.resolve('./build/'),
    publicPath: '/',
    filename: 'index.js',
    sourceMapFilename: 'index.js.map'
  },
  module: {
    loaders: [
      {
        test: /\.css$/,
        loader: ExtractTextWebpackPlugin.extract('style', 'css-loader!postcss-loader')
      },
      {
        test: /\.elm$/,
        loader: 'elm-webpack?debug=true'
      },
      {
        test: /\.(svg|jpg|gif)$/,
        loader: 'file?name=[name].[ext]'
      },
      {
        test: /\.pug/,
        loader: 'pug'
      }
    ]
  },
  resolve: {
    extensions: ['', '.js', '.elm', '.css']
  },
  plugins: process.env.NODE_ENV === 'development' ? commonPlugins : commonPlugins.concat([
    new webpack.optimize.UglifyJsPlugin({
      sourceMap: false,
      compress: {
        warnings: false
      }
    })
  ]),
  devtool: 'source-map',
  postcss () {
    return [
      postCssCssNext({
        browsers: ['ie >= 10', 'last 3 versions']
      })
    ]
  }
}

module.exports = validate(config)
