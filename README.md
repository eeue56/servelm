# Elm Http Server

Originally inspired by https://github.com/Fresheyeball/elm-http-server.


## Get started

To start Elm inside of Node simply this to the end of your compiled Elm code.

```JavaScript
Elm.worker(Elm.main);
```

Take a look at `example/run.sh` to see a complete usage

```bash
elm make example/Main.elm --output=example/main.js
echo "Elm.worker(Elm.Main);" >> example/main.js
node example/main.js
```

## Run the example

This project depends on Node.js and the `node` command.

```
sh example/run.sh
```

Test a `POST` request
```
curl --data "" localhost:8080/json
```


