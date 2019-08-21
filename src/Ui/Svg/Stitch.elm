module Ui.Svg.Stitch exposing (Config, Dir(..), Side(..), reverse, view)

import Color exposing (Color)
import Color.Manipulate as Color
import Svg.PathD as D
import TypedSvg exposing (path)
import TypedSvg.Attributes exposing (class, d, stroke, strokeLinecap, strokeWidth)
import TypedSvg.Core exposing (Attribute, Svg)
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


reverse : Side -> Side
reverse side =
    case side of
        Front ->
            Back

        Back ->
            Front


type alias Config =
    { color : Color
    , from : ( Int, Int )
    , dir : Dir
    , side : Side
    }


view : List (Attribute msg) -> Config -> Svg msg
view attrs { color, from, dir, side } =
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
         , strokeWidth <| Num 0.15
         , strokeLinecap StrokeLinecapRound
         , stroke <|
            case side of
                Front ->
                    color

                Back ->
                    Color.fadeOut 0.2 color
         , class
            [ "stitch"
            , if isSlanting dir then
                "diagonal"

              else
                "straight"
            , case side of
                Front ->
                    "front"

                Back ->
                    "back"
            ]
         ]
            ++ attrs
        )
        []


isSlanting : Dir -> Bool
isSlanting dir =
    case dir of
        Up ->
            False

        Down ->
            False

        Right ->
            False

        Left ->
            False

        _ ->
            True


main =
    TypedSvg.svg
        [ TypedSvg.Attributes.viewBox 0 0 10 10
        , TypedSvg.Attributes.width <| TypedSvg.Types.px 500
        , TypedSvg.Attributes.height <| TypedSvg.Types.px 500
        ]
        [ Cloth.view ( 10, 10 )
        , view [] { color = demoColor, from = ( 3, 3 ), dir = Up, side = Front }
        , view [] { color = demoColor, from = ( 3, 3 ), dir = Down, side = Back }
        , view [] { color = demoColor, from = ( 3, 3 ), dir = Right, side = Front }
        , view [] { color = demoColor, from = ( 3, 3 ), dir = Left, side = Back }
        , view [] { color = demoColor, from = ( 3, 3 ), dir = UpLeft, side = Front }
        , view [] { color = demoColor, from = ( 3, 3 ), dir = UpRight, side = Back }
        , view [] { color = demoColor, from = ( 3, 3 ), dir = DownRight, side = Front }
        , view [] { color = demoColor, from = ( 3, 3 ), dir = DownLeft, side = Back }
        , view [] { color = demoColor, from = ( 1, 6 ), dir = UpRight, side = Front }
        , view [] { color = demoColor, from = ( 2, 5 ), dir = Down, side = Back }
        , view [] { color = demoColor, from = ( 2, 6 ), dir = UpRight, side = Front }
        , view [] { color = demoColor, from = ( 3, 5 ), dir = Down, side = Back }
        , view [] { color = demoColor, from = ( 3, 6 ), dir = UpRight, side = Front }
        , view [] { color = demoColor, from = ( 4, 5 ), dir = Down, side = Back }
        , view [] { color = demoColor, from = ( 4, 6 ), dir = UpRight, side = Front }
        ]


demoColor =
    Color.rgb255 200 100 100
