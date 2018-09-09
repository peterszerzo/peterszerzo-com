module OverEasy.Pieces.BordersAreLenient exposing (Model, Msg(..), init, subscriptions, update, view)

import Html exposing (Html, div, node, text)
import Html.Attributes exposing (style)
import OverEasy.Pieces.BordersAreLenient.P12 as P02
import String.Future


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
        [ style "width" (String.Future.fromFloat w ++ "px")
        , style "height" (String.Future.fromFloat h ++ "px")
        ]
        [ node "style" [] [ text """
        svg * {
          fill: none;
          stroke: #000;
          stroke-linecap: round;
          stroke-linejoin: round;
        }

        .engrave * {
          stroke: #F00;
        }

        .engrave {
          transition: all 0.2s ease-in-out;
        }

        svg:hover .engrave {
          transform: translate3d(-6px, -4px, 0);
        }
        """ ]
        , P02.view
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
