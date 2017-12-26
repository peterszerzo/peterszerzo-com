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

        isVisible =
            (not model.isNotificationDismissed)
                && (timeSinceStart > Constants.showNotificationAt && timeSinceStart < Constants.hideNotificationAt)
    in
        div
            [ localClassList
                [ ( Root, True )
                , ( Visible, isVisible )
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
         , top (px 72)
         , property "width" (Mixins.calcPctMinusPx 100 40)
         , maxWidth (px 400)
         , height (px 40)
         , displayFlex
         , alignItems center
         , justifyContent spaceBetween
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
    , class Body
        [ textAlign left
        , margin (px 0)
        , color black
        , property "font-family" Styles.Constants.serif
        , paddingLeft (px 20)
        , fontSize (Css.rem 0.75)
        , descendants
            [ Elements.p
                [ fontSize inherit
                , fontFamily inherit
                , margin (px 0)
                , padding (px 0)
                , Mixins.lineHeight 1.35
                ]
            , Elements.a
                [ fontSize inherit
                , fontFamily inherit
                , color inherit
                , borderBottom3 (px 1) solid currentColor
                ]
            ]
        ]
    , mediaQuery desktop
        [ class Body
            [ fontSize (Css.rem 1)
            ]
        ]
    , class Close
        [ width (px 40)
        , height (px 40)
        , padding (px 12)
        , top (px 0)
        , right (px 0)
        , margin (px 0)
        , Mixins.regularTransition
        , descendants
            [ Elements.svg
                [ width (px 16)
                , height (px 16)
                ]
            , selector "g"
                [ property "stroke" "black"
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
