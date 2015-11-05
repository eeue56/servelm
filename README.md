# Elm Http Server

Simple bindings to Node.js's Http.Server as a `Signal (Request, Response)`. IO is handled through `Task`s.

Ideally this serves as a starting point for low level bindings, and will expand to have exhaustive bindings to Http.Server, and be the basis for other libraries such as routing.

## Get started

To get your server running, you must execute your `Task`s with `port`s. As well as start Elm inside the Node process. To start Elm inside of Node simply this to the end of your compiled Elm code.

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
