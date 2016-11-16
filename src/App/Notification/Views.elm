module Notification.Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Markdown exposing (toHtml)
import Views.Shapes.X as X
import Notification.Models as Models
import Notification.Messages exposing (Msg(..))


view : Models.Model -> Html.Html Msg
view model =
    div
        [ classList
            [ ( "notification", True )
            , ( "notification--visible", model.isVisible )
            ]
        ]
        [ toHtml
            [ class "notification__body"
            ]
            model.text
        , div
            [ class "notification__close"
            , onClick Dismiss
            ]
            [ X.view
            ]
        ]
