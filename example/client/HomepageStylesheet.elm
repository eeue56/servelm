module HomepageStylesheet where

import Stylesheets exposing (..)

exports =
    css
        |%| body
            |-| backgroundColor (rgb 173 191 160)
            |-| boxSizing borderBox
            |-| padding 12 px
