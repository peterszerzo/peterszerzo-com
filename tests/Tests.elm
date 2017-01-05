module Tests exposing (..)

import Test exposing (..)
import Expect
import Models
import Router


all : Test
all =
    describe "App"
        [ describe "Models.init"
            [ test "does not return a command" <|
                \() ->
                    Expect.equal (Models.init False Router.Home |> Tuple.second) Cmd.none
            ]
        ]
