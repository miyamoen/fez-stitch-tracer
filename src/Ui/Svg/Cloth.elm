module Ui.Svg.Cloth exposing (view, viewA, viewB)

import Color exposing (Color)
import List.Extra
import Svg.PathD as D
import TypedSvg exposing (g, path, rect)
import TypedSvg.Attributes exposing (d, fill, height, stroke, strokeWidth, width, x, y)
import TypedSvg.Core exposing (Svg)
import TypedSvg.Types exposing (Fill(..), Length(..))


view : ( Int, Int ) -> Svg msg
view ( w, h ) =
    List.Extra.lift2
        (\x y ->
            if (x + y |> modBy 2) == 0 then
                viewA ( x, y )

            else
                viewB ( x, y )
        )
        (List.range 0 <| w - 1)
        (List.range 0 <| h - 1)
        |> g []


viewA : ( Int, Int ) -> Svg msg
viewA p =
    g [] (vertical p ++ horizontal p)


viewB : ( Int, Int ) -> Svg msg
viewB p =
    g [] (horizontal p ++ vertical p)


vertical : ( Int, Int ) -> List (Svg msg)
vertical ( px, py ) =
    [ rect
        [ x <| Num <| toFloat px + 0.15
        , y <| Num <| toFloat py + 0.05
        , width <| Num 0.7
        , height <| Num 0.9
        , stroke strokeColor
        , strokeWidth <| Num 0.1
        , fill <| Fill fillColor
        ]
        []
    , rect
        [ x <| Num <| toFloat px + 0.15
        , y <| Num <| toFloat py + 0.0
        , width <| Num 0.7
        , height <| Num 1
        , fill <| Fill fillColor
        ]
        []
    ]


horizontal : ( Int, Int ) -> List (Svg msg)
horizontal ( px, py ) =
    [ rect
        [ x <| Num <| toFloat px + 0.05
        , y <| Num <| toFloat py + 0.15
        , width <| Num 0.9
        , height <| Num 0.7
        , stroke strokeColor
        , strokeWidth <| Num 0.1
        , fill <| Fill fillColor
        ]
        []
    , rect
        [ x <| Num <| toFloat px + 0.0
        , y <| Num <| toFloat py + 0.15
        , width <| Num 1
        , height <| Num 0.7
        , fill <| Fill fillColor
        ]
        []
    ]


strokeColor : Color
strokeColor =
    Color.rgb255 220 220 220


fillColor : Color
fillColor =
    Color.rgb255 240 240 240


main : Svg msg
main =
    TypedSvg.svg
        [ TypedSvg.Attributes.viewBox 0 0 20 20
        , TypedSvg.Attributes.width <| TypedSvg.Types.px 500
        , TypedSvg.Attributes.height <| TypedSvg.Types.px 500
        ]
        [ view ( 20, 20 ) ]
