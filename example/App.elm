module App where

import Html exposing (..)
import Html.Attributes exposing (src, href)
import HomepageStylesheet exposing (..)
import Stylesheets
import Json.Encode as Encode


main : Html
main =
    div
        []
        [
            div [ Html.Attributes.property "innerHTML" (Encode.string ("<style>" ++ (Stylesheets.prettyPrint 4 HomepageStylesheet.exports) ++ "</style>")) ] [],

            div
                [ ]
                [ a
                    [ href "/App.elm"
                    ]
                    [ text "This site was entirely written in Elm! Try /App.elm"
                    ]
                ]
        ]
