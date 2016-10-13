module TextBox.Models exposing (..)

import Routes.Models exposing (Route(..))
import Models exposing (Mode(..))
import Data.Markdown

type alias Model =
  { primaryContent : Maybe String
  , secondaryContent : Maybe String
  , isPrimaryContentDisplayed : Bool
  }

getModel model =
  let
    isPrimaryContentDisplayed = model.mode == Conventional
    defaultModel = Model Nothing Nothing True
  in
    case model.route of
      Home ->
        defaultModel
      Projects ->
        defaultModel
      Talks ->
        defaultModel
      Archive ->
        defaultModel
      NotFound ->
        defaultModel
      Now ->
        Model (Just Data.Markdown.now) Nothing True
      About ->
        Model (Just Data.Markdown.aboutConventional) (Just Data.Markdown.aboutReal) isPrimaryContentDisplayed
