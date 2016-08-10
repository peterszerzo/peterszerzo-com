module MobileNav.Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Routes.Models exposing (Route(..))
import Main.Messages exposing (Msg(..))
import Shapes.Falafel as Falafel
import Links.Views exposing (viewMainLinks, viewSecondaryLinks)
import Shapes.Arrow as Arrow

view model currentRoute isMobileNavActive handleToggleClick =
  div
  [ classList
    [ ("mobile-nav", True)
    , ("mobile-nav--active", model.isActive)]
    ]
  [ div [class "mobile-nav__toggle", onClick handleToggleClick] [Falafel.view isMobileNavActive]
  , div [classList [("mobile-nav__content", True), ("mobile-nav__content--at-second-tab", List.member currentRoute [Projects, Talks, Archive])]]
    [ div [class "mobile-nav__tab"]
      [ viewMainLinks "mobile-main-links" currentRoute
      ]
    , div [ class "mobile-nav__tab" ]
      [ div [ class "mobile-nav__tab-content" ]
        [ div [ class "mobile-nav__back", onClick (ChangeRoute Home) ] [ Arrow.view ]
        , viewSecondaryLinks "mobile-secondary-links" currentRoute
        ]
      ]
    ]
  ]
