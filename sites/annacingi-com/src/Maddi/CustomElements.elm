module Maddi.CustomElements exposing (swipeContainer)

import Html.Styled exposing (Attribute, Html, node)
import Html.Styled.Events exposing (on)
import Json.Decode as Decode


swipeContainer :
    { onLeft : msg
    , onRight : msg
    }
    -> List (Attribute msg)
    -> List (Html msg)
    -> Html msg
swipeContainer swipeHandlers attrs children =
    node "swipe-container"
        (attrs
            ++ [ on "panleft" (Decode.succeed swipeHandlers.onLeft)
               , on "panright" (Decode.succeed swipeHandlers.onRight)
               ]
        )
        children
