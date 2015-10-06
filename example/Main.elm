module Main where

import Http.Server exposing (..)
import Task exposing (..)
import Signal exposing (..)
import Json.Encode as Json

server : Mailbox (Request, Response)
server = mailbox (emptyReq, emptyRes)

route : (Request, Response) -> Task x ()
route (req, res) =
  case url req of
    "/"     -> writeHtml res "<h1>Wowzers!!</h1>"
    "/json" -> writeJson res (Json.object [("foo", Json.string "bar" )])
    _       -> writeHtml res "<h1>404</h1>"

port reply : Signal (Task x ())
port reply = route <~ server.signal

port serve : Task x Server
port serve =
  createServer server.address
  `andThen` listen 8080 "Listening on 8080"
