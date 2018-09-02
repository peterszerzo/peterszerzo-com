module OverEasy.Pieces exposing (..)

import UrlParser exposing (..)
import Html
import OverEasy.Pieces.MoreSimpleLessSimple as MoreSimpleLessSimple
import OverEasy.Pieces.OurBearingsAreFragile as OurBearingsAreFragile
import OverEasy.Pieces.BureaucracyIsDistracting as BureaucracyIsDistracting
import OverEasy.Pieces.BordersAreLenient as BordersAreLenient
import OverEasy.Pieces.WalkWithMe as WalkWithMe
import OverEasy.Pieces.UnderstandMe as UnderstandMe


type Route
    = OurBearingsAreFragile OurBearingsAreFragile.Model
    | MoreSimpleLessSimple MoreSimpleLessSimple.Model
    | BureaucracyIsDistracting BureaucracyIsDistracting.Model
    | BordersAreLenient BordersAreLenient.Model
    | WalkWithMe WalkWithMe.Model
    | UnderstandMe UnderstandMe.Model



-- ROUTE MATCHERS START --


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ s "more-simple-less-simple" |> map (MoreSimpleLessSimple.init |> Tuple.first |> MoreSimpleLessSimple)
        , s "our-bearings-are-fragile" |> map (OurBearingsAreFragile.init |> Tuple.first |> OurBearingsAreFragile)
        , s "bureaucracy-is-distracting" |> map (BureaucracyIsDistracting.init |> Tuple.first |> BureaucracyIsDistracting)
        , s "borders-are-lenient" |> map (BordersAreLenient.init |> Tuple.first |> BordersAreLenient)
        , s "walk-with-me" |> map (WalkWithMe.init |> Tuple.first |> WalkWithMe)
        , s "understand-me" |> map (UnderstandMe.init |> Tuple.first |> UnderstandMe)
        ]



-- ROUTE MATCHERS END --


type Msg
    = OurBearingsAreFragileMsg OurBearingsAreFragile.Msg
    | MoreSimpleLessSimpleMsg MoreSimpleLessSimple.Msg
    | BureaucracyIsDistractingMsg BureaucracyIsDistracting.Msg
    | BordersAreLenientMsg BordersAreLenient.Msg
    | WalkWithMeMsg WalkWithMe.Msg
    | UnderstandMeMsg UnderstandMe.Msg


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

        UnderstandMe _ ->
            UnderstandMe.init |> Tuple.second |> Cmd.map UnderstandMeMsg


update : Msg -> Route -> ( Route, Cmd Msg )
update msg route =
    case msg of
        MoreSimpleLessSimpleMsg localMsg ->
            case route of
                MoreSimpleLessSimple model_ ->
                    ( MoreSimpleLessSimple (MoreSimpleLessSimple.update localMsg model_ |> Tuple.first)
                    , MoreSimpleLessSimple.update localMsg model_ |> Tuple.second |> Cmd.map MoreSimpleLessSimpleMsg
                    )

                _ ->
                    ( route, Cmd.none )

        OurBearingsAreFragileMsg localMsg ->
            case route of
                OurBearingsAreFragile model_ ->
                    ( OurBearingsAreFragile (OurBearingsAreFragile.update localMsg model_ |> Tuple.first)
                    , OurBearingsAreFragile.update localMsg model_ |> Tuple.second |> Cmd.map OurBearingsAreFragileMsg
                    )

                _ ->
                    ( route, Cmd.none )

        BureaucracyIsDistractingMsg localMsg ->
            case route of
                BureaucracyIsDistracting model_ ->
                    ( BureaucracyIsDistracting (BureaucracyIsDistracting.update localMsg model_ |> Tuple.first)
                    , BureaucracyIsDistracting.update localMsg model_ |> Tuple.second |> Cmd.map BureaucracyIsDistractingMsg
                    )

                _ ->
                    ( route, Cmd.none )

        BordersAreLenientMsg localMsg ->
            case route of
                BordersAreLenient model_ ->
                    ( BordersAreLenient (BordersAreLenient.update localMsg model_ |> Tuple.first)
                    , BordersAreLenient.update localMsg model_ |> Tuple.second |> Cmd.map BordersAreLenientMsg
                    )

                _ ->
                    ( route, Cmd.none )

        WalkWithMeMsg localMsg ->
            case route of
                WalkWithMe model_ ->
                    ( WalkWithMe (WalkWithMe.update localMsg model_ |> Tuple.first)
                    , WalkWithMe.update localMsg model_ |> Tuple.second |> Cmd.map WalkWithMeMsg
                    )

                _ ->
                    ( route, Cmd.none )

        UnderstandMeMsg localMsg ->
            case route of
                UnderstandMe model_ ->
                    ( UnderstandMe (UnderstandMe.update localMsg model_ |> Tuple.first)
                    , UnderstandMe.update localMsg model_ |> Tuple.second |> Cmd.map UnderstandMeMsg
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

        UnderstandMe model ->
            UnderstandMe.view model |> Html.map UnderstandMeMsg


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

        UnderstandMe model ->
            UnderstandMe.subscriptions model |> Sub.map (UnderstandMeMsg)
