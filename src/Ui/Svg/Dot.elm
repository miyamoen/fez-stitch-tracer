module Ui.Svg.Dot exposing (Config, Style(..), view)

import Color exposing (Color)
import TypedSvg exposing (circle, g, polygon)
import TypedSvg.Attributes exposing (class, cx, cy, fill, points, r, stroke, strokeWidth)
import TypedSvg.Core exposing (Svg)
import TypedSvg.Types exposing (Fill(..), Length(..), StrokeLinecap(..))
import Ui.Svg.Cloth as Cloth


type Style
    = None
    | Circle
    | Triangle


type alias Config =
    { color : Color
    , style : Style
    , point : ( Int, Int )
    }


view : Config -> Svg msg
view { color, point, style } =
    let
        ( x, y ) =
            Tuple.mapBoth toFloat toFloat point
    in
    g [ class [ "dot" ] ]
        (circle
            [ cx <| Num x
            , cy <| Num y
            , r <| Num 0.2
            , fill <| Fill color
            ]
            []
            :: (let
                    radius =
                        0.3
                in
                case style of
                    None ->
                        []

                    Circle ->
                        [ circle
                            [ cx <| Num x
                            , cy <| Num y
                            , r <| Num radius
                            , fill FillNone
                            , stroke color
                            , strokeWidth <| Num 0.05
                            ]
                            []
                        ]

                    Triangle ->
                        let
                            toPoint degree =
                                ( x + cos (degrees degree) * radius
                                , y + sin (degrees degree) * radius
                                )
                        in
                        [ polygon
                            [ points [ toPoint 270, toPoint 30, toPoint 150 ]
                            , fill <| Fill color
                            ]
                            []
                        ]
               )
        )


main =
    TypedSvg.svg
        [ TypedSvg.Attributes.viewBox 0 0 10 10
        , TypedSvg.Attributes.width <| TypedSvg.Types.px 500
        , TypedSvg.Attributes.height <| TypedSvg.Types.px 500
        ]
        [ Cloth.view ( 10, 10 )
        , view { color = demoColor, point = ( 1, 1 ), style = None }
        , view { color = demoColor, point = ( 2, 2 ), style = Circle }
        , view { color = demoColor, point = ( 3, 3 ), style = Triangle }
        , view { color = demoColor, point = ( 4, 4 ), style = Circle }
        , view { color = demoColor, point = ( 4, 4 ), style = Triangle }
        ]


demoColor =
    Color.rgb255 200 100 100
