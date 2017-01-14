#!/bin/bash
postcss ./src/styles.css --use postcss-cssnext --output ./src/styles.compiled.css --watch &
elm-app start &
