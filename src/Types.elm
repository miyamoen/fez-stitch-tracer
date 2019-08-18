module Types exposing
    ( Chart
    , FlattenMotif
    , FlattenMotifs
    , Model
    , Motif
    , Msg(..)
    , Point
    , Points
    , Size
    , StaticChart
    , Stitch
    , Window
    )

import Tree exposing (Tree)
import Ui.Svg.Dot as UiDot
import Ui.Svg.Stitch as UiStitch


type alias Model =
    { window : Window
    , clothSize : ( Int, Int )
    }


type alias Window =
    { width : Float, height : Float }


type Msg
    = NoOp
    | ResizeWindow Int Int


type alias Point =
    ( Int, Int )


type alias Points =
    List Point


type alias Size =
    ( Int, Int )


type alias Chart =
    { size : Size
    , motifs : List Motif
    }


type alias StaticChart =
    { size : Size
    , dot : List UiDot.Config
    , stitch : List UiStitch.Config
    }


type alias Stitch =
    { start : Point
    , stitch : Points
    , reverse : Point
    , side : UiStitch.Side
    }


type alias Motif =
    Tree Stitch


type alias FlattenMotif =
    ( Stitch, List (List Stitch) )


type alias FlattenMotifs =
    List (List Stitch)



-- type alias Motif =
--     { motif : List Point
--     , repetitive : Maybe { motif : List Point, delta : Point }
--     }
