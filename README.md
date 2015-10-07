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

---

## Contribute

Found a bug? Want to add a feature?

Native glue from JavaScript to Elm is in [**wisp**. Wisp](https://github.com/Gozala/wisp) is

> Homoiconic JS with Clojure syntax, s-expressions & macros.

Basically ClojureScript lite.

The wisp wrapper can be found [here.](https://github.com/Fresheyeball/elm-chartjs/blob/master/src/Native/Wrapper.wisp)

### Building

First get the latest *Chartjs** run

```bash
sh update-from-bower.sh
```

Then you can build the artifact

```bash
sh make.sh
```

Check work in the reactor like normal.

---

## Side Note

Some of the Standard Libraries in Elm make use of the `window` global in the browser. Obviously this breaks Node.js at runtime. To alleviate the problem, this package null checks `window` and binds it to `global`. Sorry if that breaks your code or causes things to be confusing.

```clojure
(if (== (typeof window) :undefined) (set! window global))
```
