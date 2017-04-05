#!/bin/bash
postcss ./src/styles.css --use postcss-cssnext --output ./src/styles.css &&
elm-app build &&
cp -r ./src/imgs ./dist &&
cp ./dist/index.html ./dist/200.html
