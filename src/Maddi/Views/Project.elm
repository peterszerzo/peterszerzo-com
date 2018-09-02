module Maddi.Views.Project exposing (init, State, view, Data)

import Html.Styled as Html exposing (Html, div)
import Maddi.Data.Project as Project
import Maddi.Views.Carousel as Carousel
import Maddi.Views as Views


type alias State =
    { carousel : Carousel.State
    }


init : State
init =
    { carousel = Carousel.init
    }


type alias Data =
    Project.Project


type alias Config msg =
    { state : State
    , data : Data
    , toMsg : State -> Data -> msg
    }


view : Config msg -> Html msg
view { state, data, toMsg } =
    Views.layout
        [ Views.static data.content
        , Carousel.view
            { data = data.imgs
            , state = state.carousel
            , toMsg = \newState _ -> toMsg { state | carousel = newState } data
            }
        ]
