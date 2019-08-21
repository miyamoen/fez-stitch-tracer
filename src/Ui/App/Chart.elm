module Ui.App.Chart exposing (animationView, view)

import Color
import Element exposing (..)
import Json.Decode as JD
import Svg.Events exposing (on)
import Svg.Keyed as Keyed
import TypedSvg exposing (g)
import TypedSvg.Attributes exposing (class)
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
            :: List.map (Stitch.view []) stitch
            ++ List.map Dot.view dot
        )


animationView : Int -> AnimationChart -> Element Msg
animationView tick { size, stitch } =
    let
        stitchView index ordered =
            ( String.fromInt index
            , g [] <|
                if ordered.order <= tick then
                    [ Stitch.view
                        [ on "animationend" <| JD.succeed <| Tick ordered.order
                        , class [ "fast" ]
                        ]
                        ordered.stitch
                    ]

                else
                    []
            )
    in
    Svg.layout [ width fill, height fill ]
        size
        [ Cloth.view size
        , Keyed.node "g" [] <| List.indexedMap stitchView stitch
        ]
