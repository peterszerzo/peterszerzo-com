module Views.Static exposing (..)

import Html exposing (Html)
import Markdown exposing (toHtml)
import Views.Static.Styles exposing (CssClasses(..), localClass)


view : String -> Html msg
view mdContent =
    toHtml [ localClass [ Root ] ] mdContent
