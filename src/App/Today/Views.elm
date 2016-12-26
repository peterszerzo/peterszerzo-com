module Today.Views exposing (..)

import Html exposing (Html, nav, div, h1, p, text)
import Html.Attributes exposing (class, style, src, attribute)
import Html.Events exposing (onClick)
import Today.Models exposing (Model, getCurrentDeed)
import Today.Messages exposing (Msg(..))
import Today.Helpers exposing (getStartClipPath, getEndClipPath)


viewTitle : Model -> String
viewTitle model =
    getCurrentDeed model
        |> Maybe.map .title
        |> Maybe.withDefault "No title"


viewNav : Html Msg
viewNav =
    nav
        [ class "t_nav"
        ]
        [ p [ class "t_nav__item", onClick RequestRandomDeed ] [ text "↻" ]
        ]


wrapUrl : String -> String
wrapUrl s =
    "url(" ++ s ++ ")"


wrapPolygon : String -> String
wrapPolygon s =
    "polygon(" ++ s ++ ")"


viewBackground : Model -> Html Msg
viewBackground model =
    let
        startUrl =
            getCurrentDeed model
                |> Maybe.map .startGifUrl
                |> Maybe.map wrapUrl
                |> Maybe.withDefault ""

        endUrl =
            getCurrentDeed model
                |> Maybe.map .endGifUrl
                |> Maybe.map wrapUrl
                |> Maybe.withDefault ""

        ratio =
            model.ticksSinceLastDeedChange
                |> (\t -> t / 100)
                |> sin
                |> (+) 1
                |> (*) 0.5

        startClipPath =
            ratio
                |> getStartClipPath
                |> wrapPolygon

        endClipPath =
            ratio
                |> getEndClipPath
                |> wrapPolygon
    in
        div [ class "t_bg" ]
            [ div
                [ class "t_bg__element"
                , style
                    [ ( "background-image", endUrl )
                    , ( "-webkit-clip-path", endClipPath )
                    , ( "clip-path", endClipPath )
                    ]
                ]
                []
            , div
                [ class "t_bg__element"
                , style
                    [ ( "background-image", startUrl )
                    , ( "-webkit-clip-path", startClipPath )
                    , ( "clip-path", startClipPath )
                    ]
                ]
                []
            ]


view : Model -> Html Msg
view model =
    div
        [ class "t"
        ]
        [ viewBackground model
        , div
            [ class "t_banner"
            ]
            [ h1 [] [ text (viewTitle model) ]
            , viewNav
            ]
        ]
