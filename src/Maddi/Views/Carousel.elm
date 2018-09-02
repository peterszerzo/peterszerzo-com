module Maddi.Views.Carousel exposing (..)

import Html.Styled exposing (Html, div, img, button)
import Html.Styled.Attributes exposing (alt, css)
import Html.Styled.Events exposing (onClick)
import Css exposing (..)
import Maddi.Views as Views


type alias Data =
    List ( String, String )


type alias State =
    { active : Int

    -- TODO: implement expand feature
    , isExpanded : Bool
    }


init : State
init =
    { active = 0
    , isExpanded = False
    }


type alias Config msg =
    { data : Data
    , state : State
    , toMsg : State -> Data -> msg
    }


expandButton : Config msg -> Html msg
expandButton config =
    button
        [ css
            [ width (px 30)
            , height (px 30)
            , border (px 0)
            , backgroundColor (rgba 255 255 255 0.1)
            , position absolute
            , top (px 10)
            , right (px 10)
            ]
        , onClick (config.toMsg { active = config.state.active, isExpanded = True } config.data)
        ]
        []


view : Config msg -> Html msg
view config =
    let
        ( url, altAttr ) =
            config.data
                |> List.drop config.state.active
                |> List.head
                |> Maybe.withDefault ( "", "" )
    in
        div
            [ css
                [ borderRadius (px 3)
                , height (px 360)
                , position relative
                , overflow visible
                ]
            ]
            [ div
                [ css
                    [ maxWidth (pct 100)
                    , backgroundColor (rgba 0 0 0 0.08)
                    , height (pct 100)
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

                -- Placeholder for expand button
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
                                                        if index == config.state.active then
                                                            hex "898989"
                                                        else
                                                            hex "CECECE"
                                                    ]
                                                , hover
                                                    [ after
                                                        [ backgroundColor (hex "898989")
                                                        ]
                                                    ]
                                                ]
                                            , onClick (config.toMsg { active = index, isExpanded = config.state.isExpanded } config.data)
                                            ]
                                            []
                                    )
                                    config.data
                            ]
                        else
                            []
                       )
            ]
