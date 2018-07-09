module Views.Link exposing (..)

import Json.Decode as Decode
import Html.Styled exposing (Html, div, h1, p, nav, node, a, text)
import Html.Styled.Attributes exposing (href, css)
import Html.Styled.Events exposing (onWithOptions)
import Css exposing (..)
import Messages exposing (Msg(..))


link : { url : String, css : List Style, children : List (Html Msg) } -> Html Msg
link config =
    let
        isExternalLink =
            String.slice 0 4 config.url == "http" || String.slice 0 6 config.url == "mailto"

        slug =
            String.dropLeft 1 config.url
    in
        a
            ([ css config.css
             , href config.url
             ]
                ++ (if isExternalLink then
                        []
                    else
                        [ onWithOptions "click"
                            { preventDefault = True, stopPropagation = False }
                            (Navigate config.url |> Decode.succeed)
                        ]
                   )
            )
            config.children
