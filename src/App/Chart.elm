module App.Chart exposing (colorScheme, toAnimation, toStatic)

import App.Motif as Motif
import Color exposing (Color)
import List.Extra as List
import Tree
import Types exposing (..)
import Ui.Svg.Dot as UiDot
import Ui.Svg.Stitch as UiStitch


toStatic : Chart -> StaticChart
toStatic { size, motifs } =
    let
        flattens =
            Motif.listFlatten motifs

        start =
            Motif.flattensMap .start flattens
                |> List.indexedMap
                    (\depth points ->
                        List.map
                            (\point ->
                                { point = point
                                , color = colorScheme depth
                                , style = UiDot.Circle
                                }
                            )
                            points
                    )
                |> List.concat

        reverse =
            Motif.flattensMap .reverse flattens
                |> List.indexedMap
                    (\depth points ->
                        List.map
                            (\point ->
                                { point = point
                                , color = colorScheme depth
                                , style = UiDot.Triangle
                                }
                            )
                            points
                    )
                |> List.concat

        stitch =
            flattens
                |> List.indexedMap
                    (\depth -> List.map (stitchToUiConfig (colorScheme depth)))
                |> List.concat
                |> List.concat
    in
    { size = size, dot = start ++ reverse, stitch = stitch }


toAnimation : Chart -> AnimationChart
toAnimation { size, motifs } =
    let
        listTupleList =
            List.map motifToAnimation motifs
    in
    { size = size
    , frontStitch = List.concatMap Tuple.first listTupleList
    , backStitch =
        List.concatMap Tuple.second listTupleList
            |> List.map
                (\{ order, stitch } ->
                    { order = order, stitch = { stitch | side = UiStitch.Front } }
                )
    }


motifToAnimation : Motif -> ( List OrderedStitchConfig, List OrderedStitchConfig )
motifToAnimation motif =
    let
        helper order stitch =
            { order = order, stitch = stitch }
    in
    Tree.flatten motif
        |> List.concatMap
            (\stitch ->
                let
                    half =
                        stitchToUiConfig (colorScheme 0) stitch

                    reverse =
                        List.map
                            (\config -> { config | side = UiStitch.reverse config.side })
                            half
                            |> List.reverse
                in
                (half ++ reverse)
                    |> List.indexedMap helper
            )
        |> List.partition (.stitch >> .side >> (==) UiStitch.Front)


stitchToUiConfig : Color -> Stitch -> List UiStitch.Config
stitchToUiConfig color { start, stitch, reverse, side } =
    List.indexedFoldr
        (\index from ( to, acc ) ->
            ( from
            , { color = color
              , from = from
              , dir = dir from to
              , side =
                    if modBy 2 index == 0 then
                        side

                    else
                        UiStitch.reverse side
              }
                :: acc
            )
        )
        ( reverse, [] )
        (start :: stitch)
        |> Tuple.second


dir : Point -> Point -> UiStitch.Dir
dir ( fromX, fromY ) ( toX, toY ) =
    let
        dx =
            toX - fromX

        dy =
            toY - fromY
    in
    case ( ( dx, -dx ), dy, -dy ) of
        ( ( 0, _ ), _, 1 ) ->
            UiStitch.Up

        ( ( 1, _ ), _, 1 ) ->
            UiStitch.UpRight

        ( ( 1, _ ), 0, _ ) ->
            UiStitch.Right

        ( ( 1, _ ), 1, _ ) ->
            UiStitch.DownRight

        ( ( 0, _ ), 1, _ ) ->
            UiStitch.Down

        ( ( _, 1 ), 1, _ ) ->
            UiStitch.DownLeft

        ( ( _, 1 ), 0, _ ) ->
            UiStitch.Left

        ( ( _, 1 ), _, 1 ) ->
            UiStitch.UpLeft

        _ ->
            UiStitch.Up


colorScheme : Int -> Color
colorScheme depth =
    if depth < 0 then
        Color.rgb255 255 66 248

    else
        case depth of
            0 ->
                Color.rgb255 60 60 60

            1 ->
                Color.rgb255 222 88 180

            2 ->
                Color.rgb255 104 88 222

            3 ->
                Color.rgb255 236 194 69

            4 ->
                Color.rgb255 120 222 88

            5 ->
                Color.rgb255 239 211 132

            _ ->
                Color.rgb255 178 255 60
