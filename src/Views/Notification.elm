module Views.Notification exposing (..)

import Html exposing (Html, div)
import Html.Events exposing (onClick)
import Html.CssHelpers
import Css exposing (..)
import Css.Elements as Elements
import Css.Namespace exposing (namespace)
import Views.Shapes exposing (close)
import Content
import Data.State exposing (State)
import Data.AppTime as AppTime
import Messages exposing (Msg(..))
import Markdown exposing (toHtml)
import Constants
import Styles.Constants exposing (..)
import Styles.Mixins as Mixins


view : State -> Html Msg
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


cssNamespace : String
cssNamespace =
    "notification"


type CssClasses
    = Root
    | Visible
    | Body
    | Close


localClass : List class -> Html.Attribute msg
localClass =
    Html.CssHelpers.withNamespace cssNamespace |> .class


localClassList : List ( class, Bool ) -> Html.Attribute msg
localClassList =
    Html.CssHelpers.withNamespace cssNamespace |> .classList


styles : List Css.Snippet
styles =
    [ class Root
        ([ position fixed
         , backgroundColor mustard
         , top (px 40)
         , property "width" (Mixins.calcPctMinusPx 100 80)
         , height auto
         , left (pct 50)
         , borderRadius (px 3)
         , transform (translate3d (pct -50) (px 0) (px 0))
         , Mixins.zIndex 20
         , opacity (num 0)
         , property "transition" "all 1s"
         , Mixins.pointerEventsNone
         ]
            ++ Mixins.standardShadow
        )
    , mediaQuery desktop
        [ class Root
            [ width (px 360) ]
        ]
    , class Body
        [ padding4 (px 12) (px 60) (px 12) (px 20)
        , textAlign left
        , margin auto
        , color white
        , fontSize (Css.rem 1)
        , letterSpacing (Css.rem 0.04)
        , descendants
            [ Elements.p
                [ fontSize inherit
                , margin (px 0)
                , padding (px 0)
                , Mixins.lineHeight 1.35
                ]
            , Elements.a
                [ fontSize inherit
                , color inherit
                , borderBottom3 (px 1) solid white
                ]
            ]
        ]
    , class Close
        [ width (px 48)
        , height (px 48)
        , padding (px 16)
        , display inlineBlock
        , position absolute
        , top (px 0)
        , right (px 0)
        , margin (px 0)
        , Mixins.regularTransition
        , descendants
            [ Elements.svg
                [ width (pct 100)
                , height (pct 100)
                ]
            , selector "g"
                [ property "stroke" "white"
                ]
            ]
        , hover
            [ transform (scale 1.15)
            ]
        ]
    , class Visible
        [ opacity (num 1)
        , Mixins.pointerEventsAll
        ]
    ]
        |> namespace cssNamespace
