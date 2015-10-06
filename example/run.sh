if [ -e example/main.js ]
then
  rm example/main.js
fi

elm make example/Main.elm --output=example/main.js
echo "Elm.worker(Elm.Main);" >> example/main.js
node example/main.js
