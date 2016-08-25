'use strict';

const path = require('path');
const webpack = require('webpack');
const autoprefixer = require('autoprefixer');
const postCssCssNext = require('postcss-cssnext');
const postCssImport = require('postcss-import');
const validate = require('webpack-validator');
const HtmlWebpackPlugin = require('html-webpack-plugin');

const commonPlugins = [
  new HtmlWebpackPlugin({
    template: './src/index.ejs'
  }),
  new HtmlWebpackPlugin({
    filename: '200.html',
    template: './src/index.ejs'
  })
];

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
        test: /\.(svg|jpg|gif)$/,
        loader: 'file?name=[name].[ext]'
      },
      {
        test: /\.html$/,
        loader: 'file?name=[name].[ext]!html-minify'
      }
    ]
  },
  resolve: {
    extensions: ['', '.js', '.elm', '.css', '.json']
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
  postcss() {
    return [
      postCssImport(),
      postCssCssNext({
        browsers: ['ie >= 10', 'last 3 versions']
      })
    ];
  }
};

module.exports = validate(config);
