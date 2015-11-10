elm make example/server/Main.elm --output=example/main.js
echo "Elm.worker(Elm.Main);" >> example/main.js
node example/main.js
