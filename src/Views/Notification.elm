module Views.Notification exposing (..)

import Html exposing (Html, div)
import Html.Events exposing (onClick)
import Views.Shapes exposing (close)
import Content
import Models
import Models.AppTime as AppTime
import Messages exposing (Msg(..))
import Markdown exposing (toHtml)
import Views.Notification.Styles exposing (CssClasses(..), localClass, localClassList)
import Constants


view : Models.Model -> Html Msg
view model =
    let
        timeSinceStart =
            AppTime.sinceStart model.time
    in
        div
            [ localClassList
                [ ( Root, True )
                , ( Visible
                  , (not model.isNotificationDismissed)
                        && (timeSinceStart > Constants.showNotificationAt && timeSinceStart < Constants.hideNotificationAt)
                  )
                ]
            ]
            [ toHtml
                [ localClass [ Body ]
                ]
                Content.notification
            , div
                [ localClass [ Close ]
                , onClick DismissNotification
                ]
                [ close
                ]
            ]
