module TextBox.Models exposing (..)

type alias Model =
  { primaryContent : Maybe String
  , secondaryContent : Maybe String
  , isPrimaryContentDisplayed : Bool
  }
