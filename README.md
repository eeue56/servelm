# Elm Http Server

This server, along with rtfeldman's Elm stylesheets, means that we can now have full stack Elm support. At no point in the development of an application will you have to write anything other than Elm!

A demo can be found [here](http://107.170.81.176/). The styling is done through compile-time correct CSS provided by [elm-stylesheets](https://github.com/rtfeldman/elm-stylesheets).

# APIs exposed

The Http.Server module allows you to create servers and run them.

## Sending out Elm

Use the `Http.Response.writeElm` function to compile an Elm file on request. It will compile an Elm file found with `name + ".elm"". It will write the output to a file in the same folder as `name + ".html"`. This will then be served out to the client. There is no caching involved, meaning that every request that involves a call to `writeElm` will trigger a compile. Use this function as a proof of concept.

This is enabled by the [node-elm-compiler](https://github.com/rtfeldman/node-elm-compiler) package.



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


# Credit

Originally inspired by https://github.com/Fresheyeball/elm-http-server.

This is now substantially different from the original.


