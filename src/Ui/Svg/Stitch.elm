module Ui.Svg.Stitch exposing (Config, Dir(..), Side(..), view)

import Color exposing (Color)
import Svg.PathD as D
import TypedSvg exposing (path)
import TypedSvg.Attributes exposing (d, stroke, strokeLinecap, strokeWidth)
import TypedSvg.Core exposing (Svg)
import TypedSvg.Types exposing (Fill(..), Length(..), StrokeLinecap(..))
import Ui.Svg.Cloth as Cloth


type Dir
    = Up
    | Down
    | Right
    | Left
    | UpRight
    | UpLeft
    | DownRight
    | DownLeft


type Side
    = Front
    | Back


type alias Config =
    { color : Color
    , from : ( Int, Int )
    , dir : Dir
    , side : Side
    }


view : Config -> Svg msg
view { color, from, dir, side } =
    let
        from_ =
            Tuple.mapBoth toFloat toFloat from
    in
    path
        ([ d <|
            D.pathD <|
                case dir of
                    Up ->
                        [ D.M from_
                        , D.v -1
                        ]

                    Down ->
                        [ D.M from_
                        , D.v 1
                        ]

                    Right ->
                        [ D.M from_
                        , D.h 1
                        ]

                    Left ->
                        [ D.M from_
                        , D.h -1
                        ]

                    UpRight ->
                        [ D.M from_
                        , D.l ( 1, -1 )
                        ]

                    UpLeft ->
                        [ D.M from_
                        , D.l ( -1, -1 )
                        ]

                    DownRight ->
                        [ D.M from_
                        , D.l ( 1, 1 )
                        ]

                    DownLeft ->
                        [ D.M from_
                        , D.l ( -1, 1 )
                        ]
         , stroke color
         , strokeWidth <| Num 0.15
         , strokeLinecap StrokeLinecapRound
         ]
            ++ (case side of
                    Front ->
                        []

                    Back ->
                        [ TypedSvg.Attributes.strokeDasharray "0.1 0.2" ]
               )
        )
        []


main =
    TypedSvg.svg
        [ TypedSvg.Attributes.viewBox 0 0 10 10
        , TypedSvg.Attributes.width <| TypedSvg.Types.px 500
        , TypedSvg.Attributes.height <| TypedSvg.Types.px 500
        ]
        [ Cloth.view ( 10, 10 )
        , view { color = demoColor, from = ( 3, 3 ), dir = Up, side = Front }
        , view { color = demoColor, from = ( 3, 3 ), dir = Down, side = Back }
        , view { color = demoColor, from = ( 3, 3 ), dir = Right, side = Front }
        , view { color = demoColor, from = ( 3, 3 ), dir = Left, side = Back }
        , view { color = demoColor, from = ( 3, 3 ), dir = UpLeft, side = Front }
        , view { color = demoColor, from = ( 3, 3 ), dir = UpRight, side = Back }
        , view { color = demoColor, from = ( 3, 3 ), dir = DownRight, side = Front }
        , view { color = demoColor, from = ( 3, 3 ), dir = DownLeft, side = Back }
        , view { color = demoColor, from = ( 1, 6 ), dir = UpRight, side = Front }
        , view { color = demoColor, from = ( 2, 5 ), dir = Down, side = Back }
        , view { color = demoColor, from = ( 2, 6 ), dir = UpRight, side = Front }
        , view { color = demoColor, from = ( 3, 5 ), dir = Down, side = Back }
        , view { color = demoColor, from = ( 3, 6 ), dir = UpRight, side = Front }
        , view { color = demoColor, from = ( 4, 5 ), dir = Down, side = Back }
        , view { color = demoColor, from = ( 4, 6 ), dir = UpRight, side = Front }
        ]


demoColor =
    Color.rgb255 200 100 100
