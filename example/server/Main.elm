module Main where

import Http.Server exposing (..)
import Http.Request exposing (emptyReq, Request, Method(..))
import Http.Response exposing (emptyRes, Response)
import Http.Response.Write exposing
  ( writeHtml, writeJson
  , writeElm, writeFile
  , writeNode)

import Task exposing (..)
import Signal exposing (..)
import Json.Encode as Json

import ServerSideClient.App exposing (main)


server : Mailbox (Request, Response)
server = mailbox (emptyReq, emptyRes)

route : (Request, Response) -> Task x ()
route (req, res) =
  case req.method of
    GET -> case req.url of
      "/" ->
        writeElm "/client/App" res
      "/App.elm" ->
        writeFile "/client/App.elm" res
      "/foo" ->
        writeHtml "<h1>Foozle!</h1>" res
      "/bar" ->
        writeNode main res
      url ->
        writeHtml ("You tried to go to " ++ url) res

    POST ->
      res |>
        writeJson (Json.object [("foo", Json.string "bar")])

    NOOP ->
      succeed ()

    _ ->
      res |>
        writeJson (Json.string "unknown method!")

port reply : Signal (Task x ())
port reply = route <~ dropRepeats server.signal

port serve : Task x Server
port serve = createServer'
  server.address
  8080
  "Listening on 8080"
