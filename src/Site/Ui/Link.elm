module Site.Ui.Link exposing (link)

import Css exposing (..)
import Html.Styled exposing (Html, a, div, h1, nav, node, p, text)
import Html.Styled.Attributes exposing (css, href)
import Json.Decode as Decode
import Site.Messages exposing (Msg(..))


link : { url : String, css : List Style, children : List (Html Msg) } -> Html Msg
link config =
    a
        [ css config.css
        , href config.url
        ]
        config.children
