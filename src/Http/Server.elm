module Http.Server where

import Task exposing (Task)
import Signal exposing (Address)
import Native.Http

type Server = Server
type Request = Request
type Response = Response

type alias Port = Int
type alias Echo = String

createServer : Address (Request, Response) -> Task x Server
createServer = Native.Http.createServer

listen : Port -> Echo -> Server -> Task x Server
listen = Native.Http.listen
