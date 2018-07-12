module OverEasy.Pieces exposing (..)

import UrlParser exposing (..)
import Html


--

import OverEasy.Pieces.MoreSimpleLessSimple as MoreSimpleLessSimple
import OverEasy.Pieces.OurBearingsAreFragile as OurBearingsAreFragile
import OverEasy.Pieces.BureaucracyIsDistracting as BureaucracyIsDistracting
import OverEasy.Pieces.BordersAreLenient as BordersAreLenient
import OverEasy.Pieces.WalkWithMe as WalkWithMe


type Route
    = OurBearingsAreFragile OurBearingsAreFragile.Model
    | MoreSimpleLessSimple MoreSimpleLessSimple.Model
    | BureaucracyIsDistracting BureaucracyIsDistracting.Model
    | BordersAreLenient BordersAreLenient.Model
    | WalkWithMe WalkWithMe.Model


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ s "more-simple-less-simple" |> map (MoreSimpleLessSimple.init |> Tuple.first |> MoreSimpleLessSimple)
        , s "our-bearings-are-fragile" |> map (OurBearingsAreFragile.init |> Tuple.first |> OurBearingsAreFragile)
        , s "bureaucracy-is-distracting" |> map (BureaucracyIsDistracting.init |> Tuple.first |> BureaucracyIsDistracting)
        , s "borders-are-lenient" |> map (BordersAreLenient.init |> Tuple.first |> BordersAreLenient)
        , s "walk-with-me" |> map (WalkWithMe.init |> Tuple.first |> WalkWithMe)
        ]


type Msg
    = OurBearingsAreFragileMsg OurBearingsAreFragile.Msg
    | MoreSimpleLessSimpleMsg MoreSimpleLessSimple.Msg
    | BureaucracyIsDistractingMsg BureaucracyIsDistracting.Msg
    | BordersAreLenientMsg BordersAreLenient.Msg
    | WalkWithMeMsg WalkWithMe.Msg


routeInitCmd : Route -> Cmd Msg
routeInitCmd route =
    case route of
        OurBearingsAreFragile _ ->
            OurBearingsAreFragile.init |> Tuple.second |> Cmd.map OurBearingsAreFragileMsg

        MoreSimpleLessSimple _ ->
            MoreSimpleLessSimple.init |> Tuple.second |> Cmd.map MoreSimpleLessSimpleMsg

        BureaucracyIsDistracting _ ->
            BureaucracyIsDistracting.init |> Tuple.second |> Cmd.map BureaucracyIsDistractingMsg

        BordersAreLenient _ ->
            BordersAreLenient.init |> Tuple.second |> Cmd.map BordersAreLenientMsg

        WalkWithMe _ ->
            WalkWithMe.init |> Tuple.second |> Cmd.map WalkWithMeMsg


update : Msg -> Route -> ( Route, Cmd Msg )
update msg route =
    case msg of
        MoreSimpleLessSimpleMsg msg ->
            case route of
                MoreSimpleLessSimple model_ ->
                    ( MoreSimpleLessSimple (MoreSimpleLessSimple.update msg model_ |> Tuple.first)
                    , MoreSimpleLessSimple.update msg model_ |> Tuple.second |> Cmd.map MoreSimpleLessSimpleMsg
                    )

                _ ->
                    ( route, Cmd.none )

        OurBearingsAreFragileMsg msg ->
            case route of
                OurBearingsAreFragile model_ ->
                    ( OurBearingsAreFragile (OurBearingsAreFragile.update msg model_ |> Tuple.first)
                    , OurBearingsAreFragile.update msg model_ |> Tuple.second |> Cmd.map OurBearingsAreFragileMsg
                    )

                _ ->
                    ( route, Cmd.none )

        BureaucracyIsDistractingMsg msg ->
            case route of
                BureaucracyIsDistracting model_ ->
                    ( BureaucracyIsDistracting (BureaucracyIsDistracting.update msg model_ |> Tuple.first)
                    , BureaucracyIsDistracting.update msg model_ |> Tuple.second |> Cmd.map BureaucracyIsDistractingMsg
                    )

                _ ->
                    ( route, Cmd.none )

        BordersAreLenientMsg msg ->
            case route of
                BordersAreLenient model_ ->
                    ( BordersAreLenient (BordersAreLenient.update msg model_ |> Tuple.first)
                    , BordersAreLenient.update msg model_ |> Tuple.second |> Cmd.map BordersAreLenientMsg
                    )

                _ ->
                    ( route, Cmd.none )

        WalkWithMeMsg msg ->
            case route of
                WalkWithMe model_ ->
                    ( WalkWithMe (WalkWithMe.update msg model_ |> Tuple.first)
                    , WalkWithMe.update msg model_ |> Tuple.second |> Cmd.map WalkWithMeMsg
                    )

                _ ->
                    ( route, Cmd.none )


view : Route -> Html.Html Msg
view route =
    case route of
        OurBearingsAreFragile model ->
            OurBearingsAreFragile.view model |> Html.map OurBearingsAreFragileMsg

        MoreSimpleLessSimple model ->
            MoreSimpleLessSimple.view model |> Html.map MoreSimpleLessSimpleMsg

        BureaucracyIsDistracting model ->
            BureaucracyIsDistracting.view model |> Html.map BureaucracyIsDistractingMsg

        BordersAreLenient model ->
            BordersAreLenient.view model |> Html.map BordersAreLenientMsg

        WalkWithMe model ->
            WalkWithMe.view model |> Html.map WalkWithMeMsg


subscriptions : Route -> Sub Msg
subscriptions route =
    case route of
        OurBearingsAreFragile model ->
            OurBearingsAreFragile.subscriptions model |> Sub.map (OurBearingsAreFragileMsg)

        MoreSimpleLessSimple model ->
            MoreSimpleLessSimple.subscriptions model |> Sub.map (MoreSimpleLessSimpleMsg)

        BureaucracyIsDistracting model ->
            BureaucracyIsDistracting.subscriptions model |> Sub.map (BureaucracyIsDistractingMsg)

        BordersAreLenient model ->
            BordersAreLenient.subscriptions model |> Sub.map (BordersAreLenientMsg)

        WalkWithMe model ->
            WalkWithMe.subscriptions model |> Sub.map (WalkWithMeMsg)
