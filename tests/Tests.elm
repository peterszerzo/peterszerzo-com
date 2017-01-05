module Tests exposing (..)

import Test exposing (..)
import Expect
import Models
import Router
import Update
import Messages


testInit : ( Models.Model, Cmd Messages.Msg )
testInit =
    Models.init False Router.Home


all : Test
all =
    describe "App"
        [ describe "Models.init"
            [ test "returns empty command" <|
                \() ->
                    Expect.equal (testInit |> Tuple.second) Cmd.none
            ]
        , describe "Update"
            [ test "tick" <|
                \() ->
                    Expect.equal
                        (testInit
                            |> Tuple.first
                            |> Update.update (Messages.Tick 1)
                            |> Tuple.first
                            |> .time
                        )
                        1
            ]
        , describe "standardPage"
            [ test "homepage is standard page" <|
                \() ->
                    Expect.equal (testInit |> Tuple.first |> Models.standardPage) Nothing
            ]
        ]
