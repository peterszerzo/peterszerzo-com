module Maddi.Views.Carousel exposing (Config, Data, State, init, view)

import Css exposing (..)
import Css.Global as Global
import Html.Styled exposing (Html, button, div, img)
import Html.Styled.Attributes exposing (alt, css)
import Html.Styled.Events exposing (on, onClick)
import Json.Decode as Decode
import Maddi.Views as Views
import Maddi.Views.Icons as Icons
import Maddi.Views.Mixins as Mixins


type alias Data =
    List ( String, String )


type State
    = State
        { active : Int
        , isExpanded : Bool
        }


init : State
init =
    State
        { active = 0
        , isExpanded = False
        }


type alias Config msg =
    { data : Data
    , state : State
    , toMsg : State -> Data -> msg
    }


view : Config msg -> Html msg
view config =
    let
        (State state) =
            config.state

        ( url, altAttr ) =
            config.data
                |> List.drop state.active
                |> List.head
                |> Maybe.withDefault ( "", "" )

        noOp =
            config.toMsg config.state config.data
    in
    div
        [ css
            [ borderRadius (px 3)
            , position relative
            , overflow visible
            , property "z-index" "10000"
            , Css.batch <|
                if state.isExpanded then
                    [ position fixed
                    , displayFlex
                    , alignItems center
                    , justifyContent center
                    , top (px 0)
                    , bottom (px 0)
                    , left (px 0)
                    , right (px 0)
                    , width (vw 100) |> important
                    , height (vh 100) |> important
                    , backgroundColor (rgba 0 0 0 0.4)
                    ]

                else
                    [ height (px 360)
                    , backgroundColor (rgba 0 0 0 0.08)
                    ]
            ]
        ]
        [ div
            [ css
                [ width (px 35)
                , height (px 35)
                , padding (px 5)
                , backgroundColor (rgba 0 0 0 0.2)
                , property "z-index" "10000"
                , borderRadius (px 3)
                , color Mixins.white
                , position absolute
                , top (px 20)
                , right (px 20)
                , hover
                    [ backgroundColor (rgba 0 0 0 0.3)
                    ]
                , Global.children
                    [ Global.svg
                        [ width (pct 100)
                        , height (pct 100)
                        ]
                    ]
                ]
            , onClick
                (config.toMsg
                    (State
                        { state
                            | isExpanded =
                                not state.isExpanded
                        }
                    )
                    config.data
                )
            ]
            [ if state.isExpanded then
                Icons.close

              else
                Icons.expand
            ]
        , div
            [ css
                [ width (pct 100)
                , height (pct 100)
                , maxWidth (px 600)
                , maxHeight (px 400)
                , margin auto
                , displayFlex
                , alignItems center
                , justifyContent center
                , position relative
                ]
            ]
          <|
            [ img
                [ css
                    [ maxWidth (pct 100)
                    , maxHeight (pct 100)
                    , display block
                    , margin auto
                    ]
                , Html.Styled.Attributes.src url
                , alt altAttr
                ]
                []
            ]
                ++ (if List.length config.data > 1 then
                        [ div
                            [ css
                                [ position absolute
                                , width (pct 100)
                                , left (px 0)
                                , textAlign center
                                , bottom (px -22)
                                ]
                            ]
                          <|
                            List.indexedMap
                                (\index _ ->
                                    div
                                        [ css
                                            [ cursor pointer
                                            , display inlineBlock
                                            , padding (px 4)
                                            , margin2 (px 0) (px 1)
                                            , after
                                                [ property "content" "' '"
                                                , display block
                                                , width (px 10)
                                                , height (px 10)
                                                , boxSizing borderBox
                                                , borderRadius (pct 50)
                                                , property "transition" "all 0.1s"
                                                , backgroundColor <|
                                                    if index == state.active then
                                                        Mixins.yellow

                                                    else
                                                        hex "CECECE"
                                                ]
                                            , hover
                                                [ after
                                                    [ backgroundColor Mixins.yellow
                                                    ]
                                                ]
                                            ]
                                        , onClick
                                            (config.toMsg
                                                (State
                                                    { active = index
                                                    , isExpanded = state.isExpanded
                                                    }
                                                )
                                                config.data
                                            )
                                        ]
                                        []
                                )
                                config.data
                        ]

                    else
                        []
                   )
        ]
