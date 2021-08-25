module Example exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Main
import Test exposing (..)


suite : Test
suite =
    describe "Hello 함수 테스트"
        [ test "테스트1" (\_ -> Expect.equal "Hello Elm!!" (Main.hello "Elm"))
        ]
