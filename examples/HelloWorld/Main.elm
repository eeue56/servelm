module Main where

-- import Graphics.Element exposing (..)
import Http.Server exposing (..)
import Task exposing (..)
import Signal exposing (..)

server : Mailbox (Request, Response)
server = mailbox (Request, Response)

port serve : Task x Server
port serve =
  createServer server.address
  `andThen` listen 8080 "listening on 8080"
















-- -------------------------
-- --- Grr...            ---
-- -------------------------
-- main : Element
-- main = show "placeholder"
