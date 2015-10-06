module Http.Request where

type Method = GET | POST | PUT | DELETE

type alias Request =
  { method : Method
  , url : String }
