module Http.Server where

import Task exposing (Task)
import Signal exposing (Address)
import Native.Http

type Server = Server
type Request = Request
type Response = Response

createServer : Address (Request, Response) -> Int -> String -> Task x Server
createServer = Native.Http.createServer
