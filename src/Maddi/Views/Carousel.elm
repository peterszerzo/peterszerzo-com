module Maddi.Views.Carousel exposing
    ( Config
    , Data
    , State
    , init
    , subscriptions
    , view
    )

import Browser.Events as Events
import Css exposing (..)
import Css.Global as Global
import Html.Styled exposing (Html, button, div, img, text)
import Html.Styled.Attributes exposing (alt, css)
import Html.Styled.Events exposing (on, onClick)
import Json.Decode as Decode
import Maddi.Data.Image as Image
import Maddi.Views as Views
import Maddi.Views.Icons as Icons
import Maddi.Views.Mixins as Mixins


type alias Data =
    List Image.Image


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
    , toMsg : State -> msg
    }


subscriptions : State -> Sub State
subscriptions (State state) =
    Events.onKeyUp
        (Decode.field "key" Decode.string
            |> Decode.map
                (\key ->
                    case key of
                        "Escape" ->
                            State { state | isExpanded = False }

                        " " ->
                            State { state | isExpanded = True }

                        "Enter" ->
                            State { state | isExpanded = True }

                        "ArrowLeft" ->
                            State { state | active = state.active - 1 }

                        "ArrowRight" ->
                            State { state | active = state.active + 1 }

                        _ ->
                            State state
                )
        )


view : Config msg -> Html msg
view config =
    let
        (State state) =
            config.state

        displayIndex =
            if List.length config.data == 0 then
                0

            else
                modBy (List.length config.data) state.active

        imageData =
            config.data
                |> List.drop displayIndex
                |> List.head
                |> Maybe.withDefault { url = "", alt = "", credit = Nothing }
    in
    (if state.isExpanded then
        overlay

     else
        container
    )
        [ case imageData.credit of
            Just credit_ ->
                credit <| "Credit: " ++ credit_

            Nothing ->
                text ""
        , if List.length config.data > 0 then
            buttonContainer
                { onClick =
                    config.toMsg
                        (State
                            { state
                                | isExpanded =
                                    not state.isExpanded
                            }
                        )
                , icon =
                    if state.isExpanded then
                        Icons.close

                    else
                        Icons.expand
                , css =
                    [ property "z-index" "1000"
                    , top (px 10)
                    , right (px 10)
                    ]
                }

          else
            text ""
        , div
            [ css
                [ width (pct 100)
                , height (pct 100)
                , Css.batch <|
                    if state.isExpanded then
                        [ maxWidth (calc (vw 100) minus (px 20))
                        , maxHeight (calc (vh 100) minus (px 80))
                        ]

                    else
                        [ maxWidth (px 600)
                        , maxHeight (px 400)
                        ]
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
                , Html.Styled.Attributes.src imageData.url
                , alt imageData.alt
                ]
                []
            ]
                ++ (if List.length config.data > 1 then
                        [ bulletMenu
                            { count = List.length config.data
                            , active = displayIndex
                            , onClick =
                                \newDisplayIndex ->
                                    config.toMsg
                                        (State
                                            { active = newDisplayIndex
                                            , isExpanded = state.isExpanded
                                            }
                                        )
                            }
                        ]

                    else
                        []
                   )
        ]


buttonContainer : { onClick : msg, icon : Html msg, css : List Style } -> Html msg
buttonContainer config =
    div
        [ css
            [ width (px 35)
            , height (px 35)
            , padding (px 5)
            , backgroundColor (rgba 0 0 0 0.2)
            , borderRadius (px 3)
            , color Mixins.white
            , position absolute
            , Css.batch config.css
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
        , onClick config.onClick
        ]
        [ config.icon
        ]


overlay : List (Html msg) -> Html msg
overlay =
    div
        [ css
            [ property "z-index" "10000"
            , position fixed |> important
            , displayFlex
            , overflow visible
            , alignItems center
            , justifyContent center
            , top (px 0)
            , bottom (px 0)
            , left (px 0)
            , right (px 0)
            , width (vw 100) |> important
            , height (vh 100) |> important
            , backgroundColor (rgba 0 0 0 0.7)
            ]
        ]


container : List (Html msg) -> Html msg
container =
    div
        [ css
            [ borderRadius (px 3)
            , position relative
            , overflow visible
            , height (px 380)
            , backgroundColor (rgba 0 0 0 0.08)
            ]
        ]


credit : String -> Html msg
credit bodyText =
    div
        [ css
            [ backgroundColor (rgba 0 0 0 0.3)
            , padding2 (px 0) (px 6)
            , color Mixins.white
            , property "width" "fit-content"
            , whiteSpace noWrap
            , Mixins.smallType
            , position absolute
            , property "z-index" "1001"
            , bottom (px 10)
            , borderRadius (px 3)
            , left (pct 50)
            , transform <| translateX (pct -50)
            ]
        ]
        [ text bodyText
        ]


bulletMenu : { count : Int, active : Int, onClick : Int -> msg } -> Html msg
bulletMenu config =
    div
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
                                if index == config.active then
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
                    , onClick (config.onClick index)
                    ]
                    []
            )
            (List.range 0 (config.count - 1))
