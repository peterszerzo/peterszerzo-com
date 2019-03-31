module Shared.SmoothNav exposing
    ( Model
    , Msg(..)
    , NavState(..)
    , delayedNewUrl
    , init
    , initWith
    , navState
    , newUrl
    , route
    , setRoute
    , update
    )

import Browser.Navigation as Navigation
import Process
import Task


type NavState
    = Rest
    | Outbound
    | Inbound
    | Clear


type Model route
    = Model
        { route : route
        , navState : NavState
        , inbound : Float
        , outbound : Float
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
        { inbound = 50
        , outbound = 200
        }


initWith : { outbound : Float, inbound : Float } -> route -> ( Model route, Cmd (Msg route) )
initWith { outbound, inbound } initRoute =
    ( Model
        { route = initRoute
        , navState = Inbound
        , inbound = inbound
        , outbound = outbound
        }
    , Process.sleep 20
        |> Task.attempt (\_ -> RestRoute)
    )


route : Model route -> route
route (Model model) =
    model.route


setRoute : route -> Model route -> Model route
setRoute newRoute (Model model) =
    Model { model | route = newRoute }


navState : Model route -> NavState
navState (Model model) =
    model.navState


newUrl : String -> Cmd (Msg route)
newUrl newPath =
    Process.sleep 0
        |> Task.attempt (\_ -> Navigate newPath)


delayedNewUrl : String -> Cmd (Msg route)
delayedNewUrl newPath =
    Process.sleep 0
        |> Task.attempt (\_ -> DelayedNavigate newPath)


update : Navigation.Key -> Msg route -> Model route -> ( Model route, Cmd (Msg route) )
update key msg (Model model) =
    case msg of
        NoOp ->
            ( Model model, Cmd.none )

        Navigate newPath ->
            ( Model model
            , Navigation.pushUrl key newPath
            )

        DelayedNavigate newPath ->
            ( Model { model | navState = Outbound }
            , Process.sleep model.outbound
                |> Task.attempt (\_ -> DelayedNavigate2 newPath)
            )

        DelayedNavigate2 newPath ->
            ( Model { model | navState = Clear }
            , Process.sleep 20
                |> Task.attempt (\_ -> DelayedNavigate3 newPath)
            )

        DelayedNavigate3 newPath ->
            ( Model model
            , Navigation.pushUrl key newPath
            )

        RestRoute ->
            ( Model { model | navState = Rest }, Cmd.none )

        ChangeRoute newRoute ->
            ( Model
                { model
                    | route = newRoute
                    , navState =
                        if model.navState == Clear then
                            Inbound

                        else
                            model.navState
                }
            , Cmd.batch
                [ if model.navState == Clear then
                    Process.sleep model.inbound |> Task.attempt (\_ -> RestRoute)

                  else
                    Cmd.none
                ]
            )
