#!/bin/bash
rm -rf dist
mkdir dist
sed 's/\/_compile\/Main\.elm/\/elm\.js/g' index.html > dist/200.html
cp -r static dist/static
elm-make Main.elm --output dist/elm.js
surge dist overeasy.sh
