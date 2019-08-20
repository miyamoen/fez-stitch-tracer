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
animationView tick { size, frontStitch, backStitch } =
    let
        stitchView index { order, stitch } =
            ( String.fromInt index
            , g [] <|
                if order <= tick then
                    [ Stitch.view
                        [ on "animationend" <| JD.succeed <| Tick order
                        , class [ "fast" ]
                        ]
                        stitch
                    ]

                else
                    []
            )

        clothView stitch =
            Svg.layout [ width (fill |> minimum 400), height fill ]
                size
                [ Cloth.view size
                , Keyed.node "g" [] <| List.indexedMap stitchView stitch
                ]
    in
    wrappedRow [ spacing 64 ]
        [ clothView frontStitch
        , clothView backStitch
        ]
