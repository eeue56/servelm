module Http.Server
  ( createServer, listen
  , createServer'
  , writeHead, write, end
  , writeHtml, writeJson
  , Port, Code, Echo, Header, Url
  , Server, Method(..)
  , emptyReq, Request
  , emptyRes, Response
  , url, method, statusCode
  , textHtml, applicationJson
  , onRequest
  , onClose, onCloseReq
  , onCloseRes, onFinishRes) where

{-| Simple bindings to Node.js's Http.Server

# Init the server

## Instaniation
@docs createServer, createServer', listen

## Types
@docs Server, Port, Code, Echo, Url, Header

# Handle Requests
@docs Request, emptyReq

## Get meta data
@docs Method, method, url, statusCode

# Write out responses
@docs Response, emptyRes

## High level api
@docs writeHtml, writeJson

## Lower level api
@docs writeHead, write, end, textHtml, applicationJson

# Listen for events
@docs onRequest, onClose, onCloseReq, onCloseRes, onFinishRes
-}

import Task exposing (Task, succeed, andThen)
import Signal exposing (Address, Mailbox, mailbox)
import Json.Encode as Json
import Native.Http

{-| Port number for the server to listen -}
type alias Port   = Int
{-| StatusCode ie 200 or 404 -}
type alias Code   = Int
{-| Echo is a message to send to the console, effectfully -}
type alias Echo   = String
{-| Url the url of a request -}
type alias Url    = String
{-| An http header, such as content type -}
type alias Header = (String, String)

{-| Node.js native Server object
[Node Docs](https://nodejs.org/api/http.html#http_class_http_server) -}
type Server       = Server
{-| Node.js native Request object
[Node Docs](https://nodejs.org/api/http.html#http_http_incomingmessage) -}
type Request      = Request
{-| Node.js native Response object
[Node Docs](https://nodejs.org/api/http.html#http_class_http_serverresponse) -}
type Response     = Response

{-| Standard Http Methods, useful for routing -}
type Method
  = GET
  | POST
  | PUT
  | DELETE
  | NOOP

on : eventName -> target -> Signal input
on = Native.Http.on

{-| "Request" events as a Signal.
[Node docs](https://nodejs.org/api/http.html#http_event_request) -}
onRequest : Server -> Signal (Request, Response)
onRequest = on "request"

{-| "Close" events as a Signal for Servers.
[Node docs](https://nodejs.org/api/http.html#http_event_close) -}
onClose : Server -> Signal ()
onClose = on "close"

{-| "Close" events as a Signal for Request objects.
[Node docs](https://nodejs.org/api/http.html#http_event_close_2) -}
onCloseReq : Request -> Signal ()
onCloseReq = on "close"

{-| "Close" events as a Signal for Response objects.
[Node docs](https://nodejs.org/api/http.html#http_event_close_1) -}
onCloseRes : Response -> Signal ()
onCloseRes = on "close"

{-| "Finsh" events as a Signal for Reponse objects.
[Node docs](https://nodejs.org/api/http.html#http_event_finish) -}
onFinishRes : Response -> Signal ()
onFinishRes = on "finish"

{-| Create a new Http Server, and send (Request, Response) to an Address. For example

    port serve : Task x Server
    port serve = createServer server.address

[Node docs](https://nodejs.org/api/http.html#http_http_createserver_requestlistener)
-}
createServer : Address (Request, Response) -> Task x Server
createServer = Native.Http.createServer

{-| Command Server to listen on a specific port,
    and echo a message to the console when active.
    Task will not resolve until listening is successful.
    For example

    port listen : Task x Server
    port listen = listen 8080 "Listening on 8080" server

[Node Docs](https://nodejs.org/api/http.html#http_server_listen_port_hostname_backlog_callback)
-}
listen : Port -> Echo -> Server -> Task x Server
listen = Native.Http.listen

{-| Create a Http Server and listen in one command! For example

    port serve : Task x Server
    port serve = createServer' server.address 8080 "Alive on 8080!"

-}
createServer' : Address (Request, Response) -> Port -> Echo -> Task x Server
createServer' address port' echo =
  createServer address `andThen` listen port' echo

{-| Write Headers to a Response
[Node Docs](https://nodejs.org/api/http.html#http_response_writehead_statuscode_statusmessage_headers) -}
writeHead : Code -> Header -> Response -> Task x Response
writeHead = Native.Http.writeHead

{-| Write body to a Response
[Node Docs](https://nodejs.org/api/http.html#http_response_write_chunk_encoding_callback) -}
write : String -> Response -> Task x Response
write = Native.Http.write

{-| End a Response
[Node Docs](https://nodejs.org/api/http.html#http_response_end_data_encoding_callback) -}
end : Response -> Task x ()
end = Native.Http.end

{-| Requests are Native Types, and so cannot be constructed inside Elm.
`emptyReq` is a dummy Native Request object incase you need it, as the initial value of
a `Signal.Mailbox` for example. -}
emptyReq : Request
emptyReq = Native.Http.emptyReq

{-| Responses are Native Types, and so cannot be constructed inside Elm.
`emptyRes` is a dummy Native Response object incase you need it, as the initial value of
a `Signal.Mailbox` for example. -}
emptyRes : Response
emptyRes = Native.Http.emptyRes

{-| Accessor for the Url of a Request
[Node docs](https://nodejs.org/api/http.html#http_message_url) -}
url : Request -> Url
url = Native.Http.url

method' : Request -> String
method' = Native.Http.method

{-| Accessor for the Method of a Request
[Node docs](https://nodejs.org/api/http.html#http_message_method) -}
method : Request -> Method
method req =
  case method' req of
    "GET"    -> GET
    "POST"   -> POST
    "PUT"    -> PUT
    "DELETE" -> DELETE
    _        -> NOOP

{-| Accessor for the statusCode of a Request
[Node docs](https://nodejs.org/api/http.html#http_message_statuscode) -}
statusCode : Request -> Code
statusCode = Native.Http.statusCode

writeAs : Header -> Response -> String -> Task x ()
writeAs header res html =
  writeHead 200 header res
  `andThen` write html `andThen` end

{-| Html Header {"Content-Type":"text/html"}-}
textHtml : Header
textHtml = ("Content-Type", "text/html")

{-| Write out HTML to a Response. For example

    res `writeHtml` "<h1>Howdy</h1>"

 -}
writeHtml : Response -> String -> Task x ()
writeHtml = writeAs textHtml

{-| Json Header {"Content-Type":"application/json"}-}
applicationJson : Header
applicationJson = ("Content-Tyoe", "application/json")

{-| Write out JSON to a Response. For example

    res `writeJson` Json.object
      [ ("foo", Json.string "bar")
      , ("baz", Json.int 0) ]

-}
writeJson : Response -> Json.Value -> Task x ()
writeJson res = writeAs applicationJson res << Json.encode 0
