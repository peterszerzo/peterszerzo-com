module OverEasy.Pieces.BordersAreLenient exposing (Model, Msg(..), init, subscriptions, update, view)

import Html exposing (Html, div, node, text)
import Html.Attributes exposing (class, style)
import OverEasy.Pieces.BordersAreLenient.P12 as P02


type alias Model =
    {}


type Msg
    = NoOp


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )


w : Float
w =
    800


h : Float
h =
    480


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div
        [ style "width" (String.fromFloat w ++ "px")
        , style "height" (String.fromFloat h ++ "px")
        , style "background-color" "#FFFFFF"
        , style "display" "flex"
        , style "align-items" "center"
        , style "justify-content" "center"
        , class "borders-container"
        ]
        [ node "style" [] [ text """
        .borders-container svg {
          width: 600px;
        }

        .borders-container svg * {
          fill: none;
          stroke: #000;
          stroke-linecap: round;
          stroke-linejoin: round;
        }

        .borders-container .engrave * {
          stroke: #F00;
        }

        .borders-container .engrave {
          transition: all 0.2s ease-in-out;
        }

        .borders-container svg:hover .engrave {
          transform: translate3d(-6px, -4px, 0);
        }
        """ ]
        , P02.view
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
