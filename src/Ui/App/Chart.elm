module Ui.App.Chart exposing (view)

import Color
import Element exposing (..)
import Types exposing (..)
import Ui.Svg as Svg
import Ui.Svg.Cloth as Cloth
import Ui.Svg.Dot as Dot
import Ui.Svg.Stitch as Stitch


view : StaticChart -> Element msg
view { size, dot, stitch } =
    Svg.layout [ width fill, height fill ]
        size
        (Cloth.view size
            :: List.map Stitch.view stitch
            ++ List.map Dot.view dot
        )
