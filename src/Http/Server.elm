module Http.Server
  ( createServer, listen
  , writeHead, write
  , end
  , Port, Code, Echo, Header
  , Server
  , emptyReq, Request
  , emptyRes, Response) where

import Task exposing (Task, succeed)
import Signal exposing (Address, Mailbox, mailbox)
import Native.Http

type Server       = Server
type Request      = Request
type Response     = Response

type alias Port   = Int
type alias Code   = Int
type alias Echo   = String
type alias Header = (String, String)

createServer : Address (Request, Response) -> Task x Server
createServer = Native.Http.createServer

listen : Port -> Echo -> Server -> Task x Server
listen = Native.Http.listen

writeHead : Code -> Header -> Response -> Task x Response
writeHead = Native.Http.writeHead

write : String -> Response -> Task x Response
write = Native.Http.write

end : Response -> Task x ()
end = Native.Http.end

emptyReq : Request
emptyReq = Native.Http.emptyReq

emptyRes : Response
emptyRes = Native.Http.emptyRes
