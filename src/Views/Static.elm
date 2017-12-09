module Views.Static exposing (..)

import Markdown exposing (toHtml)
import Html exposing (Html)
import Html.CssHelpers
import Css exposing (..)
import Css.Elements as Elements
import Css.Namespace exposing (namespace)
import Styles.Constants exposing (..)
import Styles.Mixins as Mixins


view : String -> Html msg
view mdContent =
    toHtml [ localClass [ Root ] ] mdContent


cssNamespace : String
cssNamespace =
    "Static"


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
        , padding2 (px 30) (px 20)
        , margin auto
        , textAlign left
        , color black
        , property "font-family" Styles.Constants.serif
        , descendants
            [ Elements.h2
                [ textAlign center
                ]
            , Elements.p
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
            , each [ Elements.p, Elements.li ]
                Mixins.bodyType
            , each [ Elements.p, Elements.li, Elements.ul ]
                [ fontFamily inherit
                ]
            , Elements.ul
                [ margin (px 0)
                , listStylePosition inside
                , padding (px 0)
                ]
            , Elements.li
                [ margin2 (px 10) (px 0)
                ]
            , Elements.a
                [ fontFamily inherit
                , color blue
                , opacity (num 0.8)
                , hover
                    [ opacity (num 1)
                    , borderBottom3 (px 1) solid currentColor
                    ]
                ]
            , Elements.blockquote
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
                [ Elements.h2
                    [ marginBottom (Css.rem 3)
                    ]
                , Elements.p
                    [ margin2 (Css.rem 1.875) (px 0)
                    ]
                , each
                    [ Elements.p
                    , Elements.li
                    ]
                    [ fontSize (Css.rem 1.25)
                    ]
                ]
            ]
        ]
    ]
        |> namespace cssNamespace
