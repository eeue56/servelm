if [ -e examples/main.js ]
then
  rm examples/main.js
fi

elm make examples/Main.elm --output=examples/main.js
echo "Elm.worker(Elm.Main);" >> examples/main.js
node examples/main.js
