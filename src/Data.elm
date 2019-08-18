module Data exposing (coasterA)

import Tree exposing (singleton, tree)
import Types exposing (..)
import Ui.Svg.Stitch as Stitch


coasterA : Chart
coasterA =
    { size = ( 21, 21 )
    , motifs =
        [ -- 外枠
          tree
            { start = ( 5, 19 )
            , stitch =
                List.concatMap (\x -> [ ( x, 20 ), ( x + 1, 19 ) ]) (List.range 5 18)
                    ++ (List.map (\y -> [ ( 20, y ), ( 19, y - 1 ) ]) (List.range 3 19) |> List.reverse |> List.concat)
                    ++ (List.map (\x -> [ ( x, 1 ), ( x - 1, 2 ) ]) (List.range 3 19) |> List.reverse |> List.concat)
                    ++ List.concatMap (\y -> [ ( 1, y ), ( 2, y + 1 ) ]) (List.range 2 18)
                    ++ [ ( 2, 20 ), ( 3, 19 ), ( 3, 20 ), ( 4, 19 ), ( 4, 20 ) ]
            , reverse = ( 5, 19 )
            , side = Stitch.Back
            }
            [ singleton
                { start = ( 19, 19 )
                , stitch = []
                , reverse = ( 19, 20 )
                , side = Stitch.Back
                }
            , singleton
                { start = ( 19, 19 )
                , stitch = []
                , reverse = ( 20, 20 )
                , side = Stitch.Back
                }
            , singleton
                { start = ( 19, 2 )
                , stitch = []
                , reverse = ( 20, 2 )
                , side = Stitch.Back
                }
            , singleton
                { start = ( 19, 2 )
                , stitch = []
                , reverse = ( 20, 1 )
                , side = Stitch.Back
                }
            , singleton
                { start = ( 2, 2 )
                , stitch = []
                , reverse = ( 2, 1 )
                , side = Stitch.Back
                }
            , singleton
                { start = ( 2, 2 )
                , stitch = []
                , reverse = ( 1, 1 )
                , side = Stitch.Back
                }
            , singleton
                { start = ( 2, 19 )
                , stitch = []
                , reverse = ( 1, 19 )
                , side = Stitch.Back
                }
            , singleton
                { start = ( 2, 19 )
                , stitch = []
                , reverse = ( 1, 20 )
                , side = Stitch.Back
                }
            ]

        -- 内枠*4
        , singleton
            { start = ( 5, 17 )
            , stitch =
                List.concatMap (\x -> [ ( x, 18 ), ( x + 1, 17 ) ]) (List.range 5 15)
            , reverse = ( 16, 18 )
            , side = Stitch.Back
            }
        , singleton
            { start = ( 18, 16 )
            , stitch =
                List.map (\y -> [ ( 17, y ), ( 18, y - 1 ) ]) (List.range 6 16)
                    |> List.reverse
                    |> List.concat
            , reverse = ( 17, 5 )
            , side = Stitch.Back
            }
        , singleton
            { start = ( 16, 4 )
            , stitch =
                List.map (\x -> [ ( x, 3 ), ( x - 1, 4 ) ]) (List.range 6 16)
                    |> List.reverse
                    |> List.concat
            , reverse = ( 5, 3 )
            , side = Stitch.Back
            }
        , singleton
            { start = ( 3, 5 )
            , stitch =
                List.concatMap (\y -> [ ( 4, y ), ( 3, y + 1 ) ]) (List.range 5 15)
            , reverse = ( 4, 16 )
            , side = Stitch.Back
            }

        -- メインモチーフ
        , tree
            { start = ( 11, 10 )
            , stitch = [ ( 10, 10 ), ( 10, 11 ), ( 11, 11 ) ]
            , reverse = ( 11, 10 )
            , side = Stitch.Back
            }
            [ singleton
                { start = ( 10, 10 )
                , stitch = [ ( 11, 9 ), ( 10, 9 ), ( 11, 8 ) ]
                , reverse = ( 10, 8 )
                , side = Stitch.Front
                }
            , tree
                { start = ( 10, 10 )
                , stitch = [ ( 9, 9 ) ]
                , reverse = ( 8, 8 )
                , side = Stitch.Front
                }
                [ singleton
                    { start = ( 8, 8 )
                    , stitch = []
                    , reverse = ( 9, 8 )
                    , side = Stitch.Front
                    }
                , singleton
                    { start = ( 8, 8 )
                    , stitch = []
                    , reverse = ( 8, 9 )
                    , side = Stitch.Front
                    }
                ]
            , singleton
                { start = ( 10, 11 )
                , stitch = [ ( 9, 10 ), ( 9, 11 ), ( 8, 10 ) ]
                , reverse = ( 8, 11 )
                , side = Stitch.Back
                }
            , tree
                { start = ( 10, 11 )
                , stitch = [ ( 9, 12 ) ]
                , reverse = ( 8, 13 )
                , side = Stitch.Back
                }
                [ singleton
                    { start = ( 8, 13 )
                    , stitch = []
                    , reverse = ( 8, 12 )
                    , side = Stitch.Back
                    }
                , singleton
                    { start = ( 8, 13 )
                    , stitch = []
                    , reverse = ( 9, 13 )
                    , side = Stitch.Back
                    }
                ]
            , singleton
                { start = ( 11, 11 )
                , stitch = [ ( 10, 12 ), ( 11, 12 ), ( 10, 13 ) ]
                , reverse = ( 11, 13 )
                , side = Stitch.Front
                }
            , tree
                { start = ( 11, 11 )
                , stitch = [ ( 12, 12 ) ]
                , reverse = ( 13, 13 )
                , side = Stitch.Front
                }
                [ singleton
                    { start = ( 13, 13 )
                    , stitch = []
                    , reverse = ( 12, 13 )
                    , side = Stitch.Front
                    }
                , singleton
                    { start = ( 13, 13 )
                    , stitch = []
                    , reverse = ( 13, 12 )
                    , side = Stitch.Front
                    }
                ]

            -- 真ん中の線
            , singleton
                { start = ( 10, 10 )
                , stitch = []
                , reverse = ( 11, 11 )
                , side = Stitch.Front
                }
            , singleton
                { start = ( 11, 10 )
                , stitch = [ ( 12, 11 ), ( 12, 10 ), ( 13, 11 ) ]
                , reverse = ( 13, 10 )
                , side = Stitch.Back
                }
            , tree
                { start = ( 11, 10 )
                , stitch = [ ( 12, 9 ) ]
                , reverse = ( 13, 8 )
                , side = Stitch.Back
                }
                [ singleton
                    { start = ( 13, 8 )
                    , stitch = []
                    , reverse = ( 13, 9 )
                    , side = Stitch.Back
                    }
                , singleton
                    { start = ( 13, 8 )
                    , stitch = []
                    , reverse = ( 12, 8 )
                    , side = Stitch.Back
                    }
                ]
            ]
        ]
    }
