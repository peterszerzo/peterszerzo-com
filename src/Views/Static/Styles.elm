module Views.Static.Styles exposing (..)

import Html
import Html.CssHelpers
import Css exposing (..)
import Css.Elements exposing (h3, h2, li, ul, a, blockquote, p)
import Css.Namespace exposing (namespace)
import Styles.Constants exposing (..)
import Styles.Mixins as Mixins


cssNamespace : String
cssNamespace =
    "static"


type CssClasses
    = Root


localClass : List class -> Html.Attribute msg
localClass =
    Html.CssHelpers.withNamespace cssNamespace |> .class


localClassList : List ( class, Bool ) -> Html.Attribute msg
localClassList =
    Html.CssHelpers.withNamespace cssNamespace |> .classList


styles : List Css.Snippet
styles =
    [ class Root
        [ width (pct 100)
        , maxWidth (px 680)
        , margin auto
        , color black
        , property "font-family" Styles.Constants.serif
        , descendants
            [ h2
                [ textAlign center
                ]
            , p
                [ margin2 (Css.rem 1.5) (Css.rem 0)
                , firstOfType
                    [ paddingTop (px 0)
                    , marginTop (px 0)
                    ]
                , lastOfType
                    [ paddingBottom (px 0)
                    , marginBottom (px 0)
                    ]
                ]
            , each [ p, li ]
                Mixins.bodyType
            , each [ p, li, ul ]
                [ fontFamily inherit
                ]
            , ul
                [ margin (px 0)
                , listStylePosition inside
                , padding (px 0)
                ]
            , li
                [ margin2 (px 10) (px 0)
                ]
            , a
                [ fontFamily inherit
                , color blue
                , opacity (num 0.8)
                , hover
                    [ opacity (num 1)
                    , borderBottom3 (px 1) solid currentColor
                    ]
                ]
            , blockquote
                [ property "font-family" Styles.Constants.serif
                , margin3 (px 40) (px 0) (px 20)
                , color grey
                , fontStyle italic
                , paddingLeft (px 16)
                , borderLeft3 (px 3) solid grey
                ]
            ]
        ]
    , mediaQuery desktop
        [ class Root
            [ descendants
                [ h2
                    [ marginBottom (Css.rem 3)
                    ]
                , p
                    [ margin2 (Css.rem 2.05) (px 0)
                    ]
                , each [ p, li ]
                    [ fontSize (Css.rem 1.375)
                    ]
                ]
            ]
        ]
    ]
        |> namespace cssNamespace
