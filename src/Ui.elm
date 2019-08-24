module Ui exposing (view)

import App.Chart as Chart
import Browser exposing (Document)
import Data
import Element exposing (..)
import Element.Font as Font
import Element.Input
import Html exposing (Html)
import Types exposing (..)
import Ui.App.Chart as Chart
import Ui.App.Cloth as Cloth
import Ui.Basic.Stitch as BasicStitch
import Ui.Svg.Stitch as Stitch


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
    column
        [ width fill
        , alignTop
        , spacing 32
        , paddingXY 32 32
        ]
        [ el [ Font.size 48, decorativeFont ] <| text "Fez Stitch Tracer"

        -- , Cloth.view model
        -- , el [ width <| px 400, height <| px 400 ] <|
        --     Chart.view <|
        --         Chart.toStatic Data.coasterA
        , row [ width fill, spacing 64 ]
            [ column [ spacing 8 ]
                [ row [ width fill, spacing 32, Font.size 16 ]
                    [ row [ spacing 8 ]
                        [ BasicStitch.view [ width <| px 16 ]
                            { color = Chart.colorScheme 1
                            , from = ( 0, 1 )
                            , dir = Stitch.UpRight
                            , side = Stitch.Front
                            }
                        , text "おもて"
                        ]
                    , row [ spacing 8 ]
                        [ BasicStitch.view [ width <| px 16 ]
                            { color = Chart.colorScheme 1
                            , from = ( 0, 1 )
                            , dir = Stitch.UpRight
                            , side = Stitch.Back
                            }
                        , text "うら"
                        ]
                    , Element.Input.button [ alignRight, Font.size 24, decorativeFont ]
                        { onPress = Just ResetTick, label = text "reset" }
                    ]
                , el [ width <| px 400, height <| px 400 ] <|
                    Chart.animationView model.tick <|
                        Chart.toAnimation Data.coasterA
                ]
            , column [ width fill, spacing 32, alignTop ]
                [ row [] [ el [ width <| px 130 ] <| text "名前", text "みやも" ]
                , row [] [ el [ width <| px 130 ] <| text "ステータス", text "年度内に転職はしたいが転職活動はしたくない" ]
                , row [] [ el [ width <| px 130 ] <| text "特性", text "ちまちまやり続ける" ]
                , row []
                    [ el [ width <| px 130, alignTop ] <| text "趣味"
                    , column [ spacing 16 ]
                        [ text "刺繍"
                        , text "読書(コバルト文庫とか)"
                        , text "カラオケ（1回6時間）"
                        ]
                    ]
                , row []
                    [ el [ width <| px 130, alignTop ] <| text "日常"
                    , column [ spacing 16 ]
                        [ text "Anova nanoで低温調理肉いいぞ"
                        , text "Fit Boxingで殴る練習してる"
                        , text "Elm質問返答Bot"
                        , text "Oculus Questに興味はあるが買う踏ん切りがつかない"
                        ]
                    ]
                ]
            ]
        ]


decorativeFont : Attribute msg
decorativeFont =
    Font.family [ Font.typeface "Butterfly Kids", Font.typeface "cursive" ]



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
    [ width fill
    , height fill
    , Font.medium
    , Font.family
        [ Font.typeface "游ゴシック体"
        , Font.typeface "YuGothic"
        , Font.typeface "游ゴシック"
        , Font.typeface "Yu Gothic"
        , Font.typeface "メイリオ"
        , Font.sansSerif
        ]
    ]


toHtml : Element msg -> Html msg
toHtml el =
    layoutWith { options = options } attributes el
