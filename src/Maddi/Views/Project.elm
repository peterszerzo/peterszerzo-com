module Maddi.Views.Project exposing (Data, State, init, view)

import Html.Styled as Html exposing (Html, div)
import Maddi.Data.Project as Project
import Maddi.Views as Views
import Maddi.Views.Carousel as Carousel


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
    , toStatefulMsg : State -> Data -> msg
    }


view : Config msg -> Html msg
view config =
    let
        (State state) =
            config.state
    in
    Views.simplePageContent
        [ Views.static config.data.content
        , Carousel.view
            { data = config.data.imgs
            , state = state.carousel
            , toMsg = \newState _ -> config.toStatefulMsg (State { state | carousel = newState }) config.data
            }
        ]
