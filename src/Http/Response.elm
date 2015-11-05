module Http.Response
  ( Response, StatusCode, Header
  , emptyRes
  , write, writeHead
  , writeHtml, writeJson
  , textHtml, applicationJson
  , onCloseRes, onFinishRes
  , end
  ) where

import Native.Http
import Http.Listeners exposing (on)

import Task exposing (Task, succeed, andThen)
import Json.Encode as Json


{-| An http header, such as content type -}
type alias Header = (String, String)

{-| StatusCode ie 200 or 404 -}
type alias StatusCode = Int


{-| Node.js native Response object
[Node Docs](https://nodejs.org/api/http.html#http_class_http_serverresponse) -}
type alias Response =
  { statusCode : StatusCode }


{-| `emptyRes` is a dummy Native Response object incase you need it, as the initial value of
a `Signal.Mailbox` for example. -}
emptyRes : Response
emptyRes =
  { statusCode = 418 }


{-| Write Headers to a Response
[Node Docs](https://nodejs.org/api/http.html#http_response_writehead_statuscode_statusmessage_headers) -}
writeHead : StatusCode -> Header -> Response -> Task x Response
writeHead = Native.Http.writeHead

{-| Write body to a Response
[Node Docs](https://nodejs.org/api/http.html#http_response_write_chunk_encoding_callback) -}
write : String -> Response -> Task x Response
write = Native.Http.write

{-| End a Response
[Node Docs](https://nodejs.org/api/http.html#http_response_end_data_encoding_callback) -}
end : Response -> Task x ()
end = Native.Http.end

writeAs : Header -> Response -> String -> Task x ()
writeAs header res html =
  writeHead 200 header res
  `andThen` write html `andThen` end

{-| Write out HTML to a Response. For example

    res `writeHtml` "<h1>Howdy</h1>"

 -}
writeHtml : Response -> String -> Task x ()
writeHtml = writeAs textHtml

{-| Write out JSON to a Response. For example
    res `writeJson` Json.object
      [ ("foo", Json.string "bar")
      , ("baz", Json.int 0) ]
-}
writeJson : Response -> Json.Value -> Task x ()
writeJson res = writeAs applicationJson res << Json.encode 0


{-| Html Header {"Content-Type":"text/html"}-}
textHtml : Header
textHtml = ("Content-Type", "text/html")

{-| Json Header {"Content-Type":"application/json"}-}
applicationJson : Header
applicationJson = ("Content-Type", "application/json")


{-| "Close" events as a Signal for Response objects.
[Node docs](https://nodejs.org/api/http.html#http_event_close_1) -}
onCloseRes : Response -> Signal ()
onCloseRes = on "close"

{-| "Finsh" events as a Signal for Reponse objects.
[Node docs](https://nodejs.org/api/http.html#http_event_finish) -}
onFinishRes : Response -> Signal ()
onFinishRes = on "finish"
