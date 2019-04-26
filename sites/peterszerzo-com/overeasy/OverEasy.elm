module OverEasy exposing
    ( Model
    , Msg(..)
    , Route(..)
    , init
    , main
    , matchers
    , subscriptions
    , update
    , view
    )

import Browser
import Html
import Json.Encode as Encode
import OverEasy.Pieces.BureaucracyIsDistracting as BureaucracyIsDistracting
import OverEasy.Pieces.OurBearingsAreFragile as OurBearingsAreFragile
import OverEasy.Pieces.WalkWithMe as WalkWithMe
import Url.Parser exposing (..)


main : Program Encode.Value Model Msg
main =
    Browser.element
        { init = init OurBearingsAreFragile
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type Model
    = OurBearingsAreFragileModel OurBearingsAreFragile.Model
    | BureaucracyIsDistractingModel BureaucracyIsDistracting.Model
    | WalkWithMeModel WalkWithMe.Model


type Route
    = OurBearingsAreFragile
    | BureaucracyIsDistracting
    | WalkWithMe


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ s "our-bearings-are-fragile" |> map OurBearingsAreFragile
        , s "bureaucracy-is-distracting" |> map BureaucracyIsDistracting
        , s "walk-with-me" |> map WalkWithMe
        ]


type Msg
    = OurBearingsAreFragileMsg OurBearingsAreFragile.Msg
    | BureaucracyIsDistractingMsg BureaucracyIsDistracting.Msg
    | WalkWithMeMsg WalkWithMe.Msg


init : Route -> Encode.Value -> ( Model, Cmd Msg )
init route _ =
    case route of
        OurBearingsAreFragile ->
            OurBearingsAreFragile.init Encode.null
                |> (\( model, cmd ) ->
                        ( OurBearingsAreFragileModel model
                        , Cmd.map OurBearingsAreFragileMsg cmd
                        )
                   )

        BureaucracyIsDistracting ->
            BureaucracyIsDistracting.init Encode.null
                |> (\( model, cmd ) ->
                        ( BureaucracyIsDistractingModel model
                        , Cmd.map BureaucracyIsDistractingMsg cmd
                        )
                   )

        WalkWithMe ->
            WalkWithMe.init Encode.null
                |> (\( model, cmd ) ->
                        ( WalkWithMeModel model
                        , Cmd.map WalkWithMeMsg cmd
                        )
                   )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OurBearingsAreFragileMsg localMsg ->
            case model of
                OurBearingsAreFragileModel model_ ->
                    ( OurBearingsAreFragileModel (OurBearingsAreFragile.update localMsg model_ |> Tuple.first)
                    , OurBearingsAreFragile.update localMsg model_ |> Tuple.second |> Cmd.map OurBearingsAreFragileMsg
                    )

                _ ->
                    ( model, Cmd.none )

        BureaucracyIsDistractingMsg localMsg ->
            case model of
                BureaucracyIsDistractingModel model_ ->
                    ( BureaucracyIsDistractingModel (BureaucracyIsDistracting.update localMsg model_ |> Tuple.first)
                    , BureaucracyIsDistracting.update localMsg model_ |> Tuple.second |> Cmd.map BureaucracyIsDistractingMsg
                    )

                _ ->
                    ( model, Cmd.none )

        WalkWithMeMsg localMsg ->
            case model of
                WalkWithMeModel model_ ->
                    ( WalkWithMeModel (WalkWithMe.update localMsg model_ |> Tuple.first)
                    , WalkWithMe.update localMsg model_ |> Tuple.second |> Cmd.map WalkWithMeMsg
                    )

                _ ->
                    ( model, Cmd.none )


view : Model -> Html.Html Msg
view route =
    case route of
        OurBearingsAreFragileModel model ->
            OurBearingsAreFragile.view model |> Html.map OurBearingsAreFragileMsg

        BureaucracyIsDistractingModel model ->
            BureaucracyIsDistracting.view model |> Html.map BureaucracyIsDistractingMsg

        WalkWithMeModel model ->
            WalkWithMe.view model |> Html.map WalkWithMeMsg


subscriptions : Model -> Sub Msg
subscriptions route =
    case route of
        OurBearingsAreFragileModel model ->
            OurBearingsAreFragile.subscriptions model |> Sub.map OurBearingsAreFragileMsg

        BureaucracyIsDistractingModel model ->
            BureaucracyIsDistracting.subscriptions model |> Sub.map BureaucracyIsDistractingMsg

        WalkWithMeModel model ->
            WalkWithMe.subscriptions model |> Sub.map WalkWithMeMsg
