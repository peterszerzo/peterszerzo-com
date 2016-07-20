'use strict';

const path = require('path');
const webpack = require('webpack');
const autoprefixer = require('autoprefixer');
const postCssCssNext = require('postcss-cssnext');
const postCssImport = require('postcss-import');
const validate = require('webpack-validator');

const config = {
  entry: [
    './src/index.js'
  ],
  output: {
    path: path.resolve('./build/'),
    publicPath: '',
    filename: 'index.js',
    sourceMapFilename: 'index.js.map'
  },
  module: {
    loaders: [
      {
        test: /\.css$/,
        loaders: ['style', 'css', 'postcss']
      },
      {
        test: /\.json/,
        loaders: ['json']
      },
      {
        test: /\.elm$/,
        loaders: ['elm-webpack']
      },
      {
        test: /\.(html|svg|jpg|gif)$/,
        loader: 'file?name=[name].[ext]'
      }
    ]
  },
  resolve: {
    extensions: ['', '.js', '.elm', '.css', '.json']
  },
  plugins: process.env.NODE_ENV === 'development' ? [] : [
    new webpack.optimize.UglifyJsPlugin({
      sourceMap: false,
      compress: {
        warnings: false
      }
    })
  ],
  devtool: 'source-map',
  postcss() {
    return [
      postCssImport(),
      postCssCssNext()
    ];
  }
};

module.exports = validate(config);
