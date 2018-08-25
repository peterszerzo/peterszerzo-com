module Shared.SmoothNav
    exposing
        ( NavState(..)
        , Model
        , Msg(ChangeRoute)
        , init
        , initWith
        , navState
        , route
        , setRoute
        , update
        , newUrl
        , delayedNewUrl
        )

import Navigation
import Process
import Task
import Time


type NavState
    = Rest
    | Outbound
    | Inbound
    | Clear


type Model route
    = Model
        { route : route
        , navState : NavState
        , inbound : Time.Time
        , outbound : Time.Time
        }


type Msg route
    = ChangeRoute route
    | Navigate String
    | RestRoute
    | DelayedNavigate String
    | DelayedNavigate2 String
    | DelayedNavigate3 String
    | NoOp


init : route -> ( Model route, Cmd (Msg route) )
init =
    initWith
        { inbound = 50 * Time.millisecond
        , outbound = 200 * Time.millisecond
        }


initWith : { outbound : Time.Time, inbound : Time.Time } -> route -> ( Model route, Cmd (Msg route) )
initWith { outbound, inbound } route =
    ( Model
        { route = route
        , navState = Inbound
        , inbound = inbound
        , outbound = outbound
        }
    , Process.sleep (20 * Time.millisecond)
        |> Task.attempt (\res -> RestRoute)
    )


route : Model route -> route
route (Model model) =
    model.route


setRoute : route -> Model route -> Model route
setRoute route (Model model) =
    Model { model | route = route }


navState : Model route -> NavState
navState (Model model) =
    model.navState


newUrl : String -> Cmd (Msg route)
newUrl newPath =
    Process.sleep (0 * Time.millisecond)
        |> Task.attempt (\res -> Navigate newPath)


delayedNewUrl : String -> Cmd (Msg route)
delayedNewUrl newPath =
    Process.sleep (0 * Time.millisecond)
        |> Task.attempt (\res -> DelayedNavigate newPath)


update : Msg route -> Model route -> ( Model route, Cmd (Msg route) )
update msg (Model model) =
    case msg of
        NoOp ->
            ( Model model, Cmd.none )

        Navigate newPath ->
            ( Model model
            , Navigation.newUrl newPath
            )

        DelayedNavigate newPath ->
            ( Model { model | navState = Outbound }
            , Process.sleep model.outbound
                |> Task.attempt (\res -> DelayedNavigate2 newPath)
            )

        DelayedNavigate2 newPath ->
            ( Model { model | navState = Clear }
            , Process.sleep (20 * Time.millisecond)
                |> Task.attempt (\res -> DelayedNavigate3 newPath)
            )

        DelayedNavigate3 newPath ->
            ( Model model
            , Navigation.newUrl newPath
            )

        RestRoute ->
            ( Model { model | navState = Rest }, Cmd.none )

        ChangeRoute route ->
            ( Model
                { model
                    | route = route
                    , navState =
                        if model.navState == Clear then
                            Inbound
                        else
                            model.navState
                }
            , Cmd.batch
                [ if model.navState == Clear then
                    Process.sleep model.inbound |> Task.attempt (\res -> RestRoute)
                  else
                    Cmd.none
                ]
            )
