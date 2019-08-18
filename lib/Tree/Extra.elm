module Tree.Extra exposing (breadthFirstFoldl, depthList, tests)

import Expect
import Test exposing (Test)
import Tree exposing (Tree)


tests : Test
tests =
    Test.describe "Test.Extra"
        [ Test.test "valid breadth first search" <|
            \_ ->
                let
                    tree =
                        Tree.tree 1
                            [ Tree.tree 2
                                [ Tree.tree 5 []
                                , Tree.tree 6 [ Tree.tree 8 [ Tree.tree 9 [] ] ]
                                ]
                            , Tree.tree 3 []
                            , Tree.tree 4
                                [ Tree.tree 7 []
                                ]
                            ]
                in
                breadthFirstFoldl (::) [] tree
                    |> Expect.equal [ 9, 8, 7, 6, 5, 4, 3, 2, 1 ]
        , Test.test "depthList use" <|
            \_ ->
                let
                    tree =
                        Tree.tree 1
                            [ Tree.tree 2
                                [ Tree.tree 5 []
                                , Tree.tree 6 [ Tree.tree 8 [ Tree.tree 9 [] ] ]
                                ]
                            , Tree.tree 3 []
                            , Tree.tree 4
                                [ Tree.tree 7 []
                                ]
                            ]
                in
                depthList tree
                    |> Expect.equal [ [ 2, 3, 4 ], [ 5, 6, 7 ], [ 8 ], [ 9 ] ]
        , Test.test "depthList for singleton" <|
            \_ ->
                let
                    tree =
                        Tree.tree 1 []
                in
                depthList tree
                    |> Expect.equal []
        ]


breadthFirstFoldl : (a -> acc -> acc) -> acc -> Tree a -> acc
breadthFirstFoldl f acc tree =
    breadthFirstFoldlHelp f (f (Tree.label tree) acc) (Tree.children tree)
        |> Tuple.first


breadthFirstFoldlHelp : (a -> acc -> acc) -> acc -> List (Tree a) -> ( acc, List (Tree a) )
breadthFirstFoldlHelp f acc queue =
    case queue of
        tree :: rest ->
            let
                acc_ =
                    f (Tree.label tree) acc

                queue_ =
                    rest ++ Tree.children tree
            in
            breadthFirstFoldlHelp f acc_ queue_

        [] ->
            ( acc, [] )


depthList : Tree a -> List (List a)
depthList tree =
    case Tree.children tree of
        [] ->
            []

        children ->
            depthListHelp children []
                |> List.reverse


depthListHelp : List (Tree a) -> List (List a) -> List (List a)
depthListHelp forest acc =
    let
        acc_ =
            List.map Tree.label forest :: acc

        descendants =
            List.concatMap Tree.children forest
    in
    if List.isEmpty descendants then
        acc_

    else
        depthListHelp descendants acc_
