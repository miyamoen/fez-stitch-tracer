module Ui exposing (view)

import Browser exposing (Document)
import Element exposing (..)
import Html exposing (Html)
import Route
import Types exposing (..)
import Ui.Pages.Top


view : Model -> Document Msg
view model =
    { title = toTitle model
    , body = [ toHtml <| view model ]
    }


toTitle : Model -> String
toTitle model =
    "Fez Stitch Tracer"


view : Model -> Element msg
view model =
    text "Hello"



-- helper


options : List Option
options =
    [ focusStyle
        { borderColor = Nothing
        , backgroundColor = Nothing
        , shadow = Nothing
        }
    ]


attributes : List (Attribute msg)
attributes =
    [ width fill, height fill ]


toHtml : Element msg -> Html msg
toHtml element =
    layoutWith { options = options } attributes element
