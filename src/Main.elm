module Main exposing (init, update)

import Browser exposing (Document)
import Browser.Events
import Data
import Process exposing (sleep)
import Task
import Types exposing (..)
import Ui exposing (view)


main : Program Window Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : Window -> ( Model, Cmd Msg )
init window =
    ( { window = window
      , tick = 0
      , clothSize = ( 43, 43 )
      , charts = [ { name = "coaster a", chart = Data.coasterA } ]
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Tick tick ->
            if tick + 1 > model.tick then
                ( { model | tick = tick + 1 }, Cmd.none )

            else
                ( model, Cmd.none )

        ResetTick ->
            ( { model | tick = -1 }, sleep 500 |> Task.perform (always <| Tick 0) )

        ResizeWindow w h ->
            ( { model | window = { width = toFloat w, height = toFloat h } }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Browser.Events.onResize ResizeWindow
