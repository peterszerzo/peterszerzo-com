module Maddi.Ui.Project exposing (Data, State, init, subscriptions, view)

import Css exposing (..)
import Html.Styled as Html exposing (Html, div, h1, text)
import Html.Styled.Attributes exposing (css)
import Maddi.Data.Project as Project
import Maddi.Ui as Ui
import Maddi.Ui.Carousel as Carousel


type State
    = State
        { carousel : Carousel.State
        }


init : State
init =
    State
        { carousel = Carousel.init
        }


type alias Data =
    Project.Project


type alias Config msg =
    { state : State
    , data : Data
    , toMsg : State -> msg
    }


subscriptions : State -> Sub State
subscriptions (State state) =
    Carousel.subscriptions state.carousel
        |> Sub.map (\newCarousel -> State { state | carousel = newCarousel })


view : Config msg -> { content : Html msg, overlay : List (Html msg) }
view config =
    let
        (State state) =
            config.state

        carouselView =
            Carousel.view
                { data = config.data.imgs
                , state = state.carousel
                , toMsg = \newState -> config.toMsg (State { state | carousel = newState })
                }
    in
    { content =
        Ui.simplePageContent
            { title = config.data.title
            , left =
                div []
                    [ div
                        [ css
                            [ marginBottom (px 20)
                            ]
                        ]
                      <|
                        List.map (Ui.tag True) config.data.tags
                    , Ui.static config.data.content
                    ]
            , right = carouselView.content
            }
    , overlay = carouselView.overlay
    }
