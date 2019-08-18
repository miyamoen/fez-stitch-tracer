module App.Motif exposing (flatten, flattensMap, listFlatten)

import Tree exposing (Tree)
import Tree.Extra as Tree
import Types exposing (..)


flatten : Motif -> FlattenMotif
flatten motif =
    ( Tree.label motif, Tree.depthList motif )


listFlatten : List Motif -> FlattenMotifs
listFlatten motifs =
    case motifs of
        head :: tail ->
            -- root要素は構築するためにしょうがなくいれてる
            Tree.tree (Tree.label head) motifs
                |> Tree.depthList

        [] ->
            []


flattensMap : (Stitch -> a) -> FlattenMotifs -> List (List a)
flattensMap f motifs =
    List.map (List.map f) motifs
