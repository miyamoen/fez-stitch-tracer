module LibTests exposing (suite)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import Tree.Extra


suite : Test
suite =
    describe "lib tests"
        [ Tree.Extra.tests
        ]
