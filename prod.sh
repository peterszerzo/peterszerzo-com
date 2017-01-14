#!/bin/bash
postcss ./src/styles.css --use postcss-cssnext --output ./src/styles.compiled.css &&
elm-app build &&
cp ./dist/index.html ./dist/200.html
