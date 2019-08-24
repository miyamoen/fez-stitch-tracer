module Ui.Basic.Stitch exposing (view)

import Color
import Element exposing (..)
import Types exposing (..)
import Ui.Svg as Svg
import Ui.Svg.Cloth as Cloth
import Ui.Svg.Stitch as Stitch exposing (Dir(..), Side(..))


view : List (Attribute msg) -> Stitch.Config -> Element msg
view attrs config =
    Svg.layout attrs
        ( 1, 1 )
        [ Cloth.view ( 1, 1 )
        , Stitch.view [] config
        ]
