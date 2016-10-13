module Models exposing (..)

import Notification.Models
import Messages exposing (Msg)
import Router exposing (Route)
import Data.Markdown

type alias IsNotificationDismissed = Bool

type alias Flags = IsNotificationDismissed

type Mode = Conventional | Real

type alias MobileNav =
  { isActive : Bool
  }

type SwitchPosition
  = Left
  | Center
  | Right

type alias SubLink = (String, String)

type Url = Internal Route | External String

type alias Link =
  { label : String
  , url : Url
  , subLinks : List SubLink
  }

type alias TextBox =
  { primaryContent : Maybe String
  , secondaryContent : Maybe String
  , isPrimaryContentDisplayed : Bool
  }

type alias Model =
  { route : Route
  , mode : Mode
  , time : Float
  , mobileNav : MobileNav
  , notification : Notification.Models.Model
  }

init : Flags -> Route -> (Model, Cmd Msg)
init isNotificationDismissed route =
  let
    mobileNav = MobileNav False
    notification = Notification.Models.init isNotificationDismissed
  in
    ( Model route Conventional 0 mobileNav notification
    , Cmd.none
    )


-- Helpers

getTextBox : Model -> TextBox
getTextBox model =
  let
    isPrimaryContentDisplayed = model.mode == Conventional
    defaultModel = TextBox Nothing Nothing True
  in
    case model.route of
      Router.Now ->
        TextBox (Just Data.Markdown.now) Nothing True

      Router.About ->
        TextBox
          (Just Data.Markdown.aboutConventional)
          (Just Data.Markdown.aboutReal)
          isPrimaryContentDisplayed

      _ ->
        defaultModel

getActiveSubLinks : (List Link) -> Route -> (List SubLink)
getActiveSubLinks links currentRoute =
  links
    |> List.filter (\lnk -> lnk.url == Internal currentRoute)
    |> List.head
    |> Maybe.map .subLinks
    |> Maybe.withDefault []
