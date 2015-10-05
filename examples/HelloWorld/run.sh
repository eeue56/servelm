if [ -e examples/HelloWorld/main.js ]
then
  rm examples/HelloWorld/main.js
fi

elm make examples/HelloWorld/Main.elm --output=examples/HelloWorld/main.js
echo "Elm.worker(Elm.Main);" >> examples/HelloWorld/main.js
node examples/HelloWorld/main.js
# rm examples/HelloWorld/main.js
