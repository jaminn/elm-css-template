module Main exposing (..)

import Browser
import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)
import Task
import Time



-- MAIN


main =
    Browser.element
        { init = init
        , view = view >> toUnstyled
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { zone : Time.Zone
    , time : Time.Posix
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model Time.utc (Time.millisToPosix 0)
    , Task.perform AdjustTimeZone Time.here
    )



-- UPDATE


type Msg
    = Tick Time.Posix
    | AdjustTimeZone Time.Zone


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            ( { model | time = newTime }
            , Cmd.none
            )

        AdjustTimeZone newZone ->
            ( { model | zone = newZone }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every 1000 Tick



-- VIEW


hello : String -> String
hello name =
    String.concat [ "Hello ", name, "!!" ]


view : Model -> Html Msg
view model =
    let
        hour =
            String.fromInt (Time.toHour model.zone model.time)

        minute =
            String.fromInt (Time.toMinute model.zone model.time)

        second =
            String.fromInt (Time.toSecond model.zone model.time)
    in
    div
        [ css
            [ backgroundColor (hex "#444")
            , padding (px 10)
            , margin (px 20)
            , borderRadius (px 10)
            , boxShadow4 (px 1) (px 1) (px 5) (hex "#777")
            ]
        ]
        [ div [ css [ fontSize (px 30), color (hex "#fff") ] ] [ text (hello "world") ]
        , div [ css [ fontSize (px 30), color (hex "#fff") ] ] [ text (hour ++ ":" ++ minute ++ ":" ++ second) ]
        ]
