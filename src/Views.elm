module Views exposing (..)

import Html exposing (Html, div, text, h1, h2, p, header, node)
import Router
import Messages exposing (Msg(..))
import Views.ContentBox
import Views.Background
import Content
import Views.Banner
import Views.Static
import Views.Projects
import Views.Styles exposing (CssClasses(..), localClass)
import Styles exposing (css)
import Styles.Raw exposing (raw)
import Css.File exposing (compile)


a =
    42
