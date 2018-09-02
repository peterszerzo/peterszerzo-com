module Maddi.Views.CustomLink exposing (..)

import Css exposing (..)
import Json.Decode as Decode
import Html.Styled exposing (Html, text, div, a, p, br, header, h2, fromUnstyled)
import Html.Styled.Attributes exposing (css, href)
import Html.Styled.Events exposing (onWithOptions, onClick)


customLink : { navigate : String -> msg, url : String, css : Style } -> List (Html msg) -> Html msg
customLink config children =
    a
        ([ href config.url
         , css [ config.css ]
         ]
            ++ (if List.member (String.left 4 config.url) [ "http", "mail" ] then
                    []
                else
                    [ onWithOptions "click" { preventDefault = True, stopPropagation = False } (config.navigate config.url |> Decode.succeed) ]
               )
        )
        children
