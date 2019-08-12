module Types exposing (Model, Msg(..), Window)


type alias Model =
    { window : Window }


type alias Window =
    { width : Float, height : Float }


type Msg
    = NoOp
    | ResizeWindow Int Int
