module Ui exposing (view)

import App.Chart as Chart
import Browser exposing (Document)
import Data
import Element exposing (..)
import Element.Font as Font
import Html exposing (Html)
import Types exposing (..)
import Ui.App.Chart as Chart
import Ui.App.Cloth as Cloth


view : Model -> Document Msg
view model =
    { title = toTitle model
    , body = [ toHtml <| element model ]
    }


toTitle : Model -> String
toTitle model =
    "Fez Stitch Tracer"


element : Model -> Element Msg
element model =
    column [ width fill, spacing 32, paddingXY 32 32 ]
        [ el
            [ Font.size 48
            , Font.family [ Font.typeface "Butterfly Kids", Font.typeface "cursive" ]
            ]
          <|
            text "Fez Stitch Tracer"

        -- , Cloth.view model
        -- , el [ width <| px 400, height <| px 400 ] <|
        --     Chart.view <|
        --         Chart.toStatic Data.coasterA
        , el [ width <| px 400, height <| px 400 ] <|
            Chart.animationView model.tick <|
                Chart.toAnimation Data.coasterA
        ]



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
toHtml el =
    layoutWith { options = options } attributes el
