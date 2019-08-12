module Ui.Pages.Top exposing (view)

import Element exposing (..)
import Element.Background as Background
import Types exposing (..)


view : Window -> Element Msg
view window =
    column
        [ width fill
        , height fill
        , Background.color <| rgb255 235 235 235
        ]
        [ text "top" ]
