module Main where

import Graphics.Element exposing (..)
import Http exposing (..)

server : Mailbox (Request, Response)
server = mailbox (_, _)

port listen : Task x Server
port listen = createServer server.address 8080 "listening on 8080"

main : Element
main = show "placeholder"
