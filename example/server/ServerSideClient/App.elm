module ServerSideClient.App where

import Html exposing (..)
import Html.Attributes exposing (id, src, href)
import ServerSideClient.HomepageStylesheet exposing (exports)
import ServerSideClient.Stylesheets as Stylesheets
import Json.Encode as Encode


main : Html
main =
    div
        [ id "dave" ]
        [
            div [ Html.Attributes.property "innerHTML" (Encode.string ("<style>" ++ (Stylesheets.prettyPrint 4 exports) ++ "</style>")) ] [],

            div
                [ ]
                [ text "This page was rendered on the server!"
                ]
        ]
