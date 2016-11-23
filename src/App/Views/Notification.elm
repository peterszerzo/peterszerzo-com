module Views.Notification exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Markdown exposing (toHtml)
import Views.Shapes.X as X
import Messages exposing (Msg(..))
import Models


view : Models.Model -> Html.Html Msg
view model =
    div
        [ classList
            [ ( "notification", True )
            , ( "notification--visible", (not model.isNotificationDismissed) && (model.time > 3 && model.time < 60))
            ]
        ]
        [ toHtml
            [ class "notification__body"
            ]
            model.notificationContent
        , div
            [ class "notification__close"
            , onClick DismissNotification
            ]
            [ X.view
            ]
        ]
