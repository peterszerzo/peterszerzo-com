module Views.Switch exposing (..)

import Html.Styled exposing (Html, div)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (onClick)
import Css exposing (..)
import Styles.Constants exposing (..)


rightStyles : List Style
rightStyles =
    [ property "transition" "transform .3s"
    , transform (translate3d (px 12) (px 0) (px 0))
    ]


view : Bool -> msg -> Html msg
view isRight handleClick =
    div
        [ css
            [ display inlineBlock
            , width (px 28)
            , height (px 16)
            , borderRadius (px 8)
            , overflow hidden
            , opacity (num 1)
            , position relative
            , property "transition" "opacity .3s"
            , borderColor black
            , property "border-width" "1px"
            , borderStyle solid
            ]
        , onClick handleClick
        ]
        [ div
            [ css
                [ width (px 16)
                , height (px 16)
                , borderRadius (pct 50)
                , boxSizing borderBox
                , border3 (px 1) solid black
                , backgroundColor white
                , position absolute
                , top (px -1)
                , left (px -1)
                , transform (translate3d (px 0) (px 0) (px 0))
                , property "z-index" "1"
                , Css.batch <|
                    if isRight then
                        rightStyles
                    else
                        []
                ]
            ]
            []
        , div
            [ css
                [ width (px 30)
                , height (px 16)
                , backgroundColor black
                , position absolute
                , top (px 0)
                , left (px -22)
                , property "z-index" "0"
                , Css.batch <|
                    if isRight then
                        rightStyles
                    else
                        []
                ]
            ]
            []
        ]
