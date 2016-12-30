postcss ./src/styles.css --use postcss-cssnext --output ./src/styles.compiled.css
elm-app build
sed -i -e 's/js\/main/\/js\/main/g' ./dist/index.html
sed -i -e 's/css\/main/\/css\/main/g' ./dist/index.html
cp ./dist/index.html ./dist/200.html
