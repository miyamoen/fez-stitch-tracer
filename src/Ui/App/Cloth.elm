module Ui.App.Cloth exposing (view)

import Color
import Element exposing (..)
import Types exposing (..)
import Ui.Svg as Svg
import Ui.Svg.Cloth as Cloth
import Ui.Svg.Stitch as Stitch exposing (Dir(..), Side(..))


view : Model -> Element Msg
view { clothSize } =
    Svg.layout [ width fill, height fill ]
        clothSize
        [ Cloth.view clothSize
        , Stitch.view { color = demoColor, from = ( 3, 3 ), dir = Up, side = Front }
        , Stitch.view { color = demoColor, from = ( 3, 3 ), dir = Down, side = Back }
        , Stitch.view { color = demoColor, from = ( 3, 3 ), dir = Right, side = Front }
        , Stitch.view { color = demoColor, from = ( 3, 3 ), dir = Left, side = Back }
        , Stitch.view { color = demoColor, from = ( 3, 3 ), dir = UpLeft, side = Front }
        , Stitch.view { color = demoColor, from = ( 3, 3 ), dir = UpRight, side = Back }
        , Stitch.view { color = demoColor, from = ( 3, 3 ), dir = DownRight, side = Front }
        , Stitch.view { color = demoColor, from = ( 3, 3 ), dir = DownLeft, side = Back }
        , Stitch.view { color = demoColor, from = ( 1, 6 ), dir = UpRight, side = Front }
        , Stitch.view { color = demoColor, from = ( 2, 5 ), dir = Down, side = Back }
        , Stitch.view { color = demoColor, from = ( 2, 6 ), dir = UpRight, side = Front }
        , Stitch.view { color = demoColor, from = ( 3, 5 ), dir = Down, side = Back }
        , Stitch.view { color = demoColor, from = ( 3, 6 ), dir = UpRight, side = Front }
        , Stitch.view { color = demoColor, from = ( 4, 5 ), dir = Down, side = Back }
        , Stitch.view { color = demoColor, from = ( 4, 6 ), dir = UpRight, side = Front }
        ]


demoColor : Color.Color
demoColor =
    Color.rgb255 200 100 100
