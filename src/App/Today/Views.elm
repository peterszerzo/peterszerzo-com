module Today.Views exposing (..)

import Html exposing (Html, nav, div, h1, p, text)
import Html.Attributes exposing (class, style, src, attribute)
import Html.Events exposing (onClick)
import Today.Models exposing (Model, getCurrentDeed)
import Today.Messages exposing (Msg(..))
import Today.Helpers exposing (getClipPath)


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


viewBackground : Model -> Html Msg
viewBackground model =
    let
        startUrl =
            getCurrentDeed model
                |> Maybe.map .startGifUrl
                |> Maybe.map (\s -> "url(" ++ s ++ ")")
                |> Maybe.withDefault ""

        endUrl =
            getCurrentDeed model
                |> Maybe.map .endGifUrl
                |> Maybe.map (\s -> "url(" ++ s ++ ")")
                |> Maybe.withDefault ""

        ratio =
            model.ticksSinceLastDeedChange
                |> (\t -> t / 50)
                |> sin
                |> (+) 1
                |> (*) 0.5
                |> Debug.log "ratio"

        clipPath =
            getClipPath ratio

        clipPathString =
            "polygon(" ++ clipPath ++ ")"
    in
        div [ class "t_bg" ]
            [ div
                [ class "t_bg__element"
                , attribute "style" ("background-image: " ++ endUrl ++ ";")
                ]
                []
            , div
                [ class "t_bg__element"
                , attribute
                    "style"
                    ("background-image: " ++ startUrl ++ "; -webkit-clip-path: " ++ clipPathString ++ ";")
                ]
                []
            , div [ class "t_bg__element t_bg__overlay" ] []
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
