module Views.Notification exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Markdown exposing (toHtml)
import Views.Shapes.X as X
import Messages exposing (Msg(..))
import Models
import Content


view : Models.Model -> Html.Html Msg
view model =
    div
        [ classList
            [ ( "notification", True )
            , ( "notification--visible", (not model.isNotificationDismissed) && (model.time > 12 && model.time < 75) )
            ]
        ]
        [ toHtml
            [ class "notification__body"
            ]
            Content.notification
        , div
            [ class "notification__close"
            , onClick DismissNotification
            ]
            [ X.view
            ]
        ]
