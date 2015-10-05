module Main where

import Http.Server exposing (..)
import Task exposing (..)
import Signal exposing (..)

server : Mailbox (Request, Response)
server = mailbox (emptyReq, emptyRes)

route : (Request, Response) -> Task x ()
route (_, res) =
  writeHead 200 ("Content-Type", "text/html") res
  `andThen` write "<h1>Wowzers!</h1>"
  `andThen` end

port reply : Signal (Task x ())
port reply = route <~ server.signal

port serve : Task x Server
port serve =
  createServer server.address
  `andThen` listen 8080 "listening on 8080"
