# Servelm - Elm Http Server

This server, along with rtfeldman's Elm stylesheets, means that we can now have full stack Elm support. At no point in the development of an application will you have to write anything other than Elm!

It now supports server-side rendering of elm-html.

A demo can be found [here](http://107.170.81.176/). The styling is done through compile-time correct CSS provided by [elm-stylesheets](https://github.com/rtfeldman/elm-stylesheets).

# APIs exposed

The Http.Server module allows you to create servers and run them.

## Sending out Elm

Use the `Http.Response.writeElm` function to compile an Elm file on request. It will compile an Elm file found with `name + ".elm""`. It will write the output to a file in the same folder as `name + ".html"`. This will then be served out to the client. There is basic caching involved at the moment, which works based on the lifecycle of the server. Restart the server if you make any changes.

This is enabled by the [node-elm-compiler](https://github.com/rtfeldman/node-elm-compiler) package.

It also supports server-side rendering of elm-html, through using the [vdom-to-html](https://github.com/nthtran/vdom-to-html) package.


## Get started

To start Elm inside of Node simply this to the end of your compiled Elm code.

```JavaScript
Elm.worker(Elm.Main);
```

Take a look at `example/run.sh` to see a complete usage

```bash
elm make example/server/Main.elm --output=example/main.js
echo "Elm.worker(Elm.Main);" >> example/main.js
node example/main.js
```

## Run the example

This project depends on Node.js and the `node` command.

```bash
example/run.sh
```

Then load up the browser to see it working!


# Credit

Originally inspired by https://github.com/Fresheyeball/elm-http-server.

There was some great work already there, I just cleaned it up a little and integrated it with some other packages.

