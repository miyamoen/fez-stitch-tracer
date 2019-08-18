module Ui.Svg exposing (layout)

import Color exposing (Color)
import Element exposing (Attribute, Element, el, html)
import TypedSvg
import TypedSvg.Attributes exposing (height, viewBox, width)
import TypedSvg.Core exposing (Svg)
import TypedSvg.Types


layout : List (Attribute msg) -> ( Int, Int ) -> List (Svg msg) -> Element msg
layout attrs ( w, h ) svgs =
    el attrs <|
        html <|
            TypedSvg.svg
                [ viewBox 0 0 (toFloat w) (toFloat h)
                , width <| TypedSvg.Types.percent 100
                , height <| TypedSvg.Types.percent 100
                ]
                svgs
