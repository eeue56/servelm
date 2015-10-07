module Main where

import Http.Server exposing (..)
import Task exposing (..)
import Signal exposing (..)
import Json.Encode as Json

server : Mailbox (Request, Response)
server = mailbox (emptyReq, emptyRes)

route : (Request, Response) -> Task x ()
route (req, res) =
  case method req of
    GET -> case url req of
      "/"    -> writeHtml res "<h1>Wowzers</h1>"
      "/foo" -> writeHtml res "<h1>Foozle!</h1>"
      _      -> writeHtml res "<h1>404</h1>"
    POST ->
      Json.object [("foo", Json.string "bar")]
      |> writeJson res
    NOOP -> succeed ()
    _ ->
      Json.string "fail"
      |> writeJson res

port reply : Signal (Task x ())
port reply = route <~ dropRepeats server.signal

port serve : Task x Server
port serve = createServer'
  server.address
  8080
  "Listening on 8080"
