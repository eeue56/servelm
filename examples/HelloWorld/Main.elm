module Main where

import Http.Server exposing (..)
import Task exposing (..)
import Signal exposing (..)

server : Mailbox (Request, Response)
server = mailbox (emptyReq, emptyRes)

route : (Request, Response) -> Task x ()
route (req, res) = case url req of
  "/"    -> res `writeHtml` "<h1>Wowzers!!</h1>"
  "/foo" -> res `writeHtml` "<h1>Foozle!</h1>"
  _      -> res `writeHtml` "<h1>404</h1>"

port reply : Signal (Task x ())
port reply = route <~ server.signal

port serve : Task x Server
port serve =
  createServer server.address
  `andThen` listen 8080 "listening on 8080"
