module Platformer exposing (main)
import Browser
import Browser
import Browser.Events
import Html exposing (Html, div, text)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Json.Decode as Decode
  
-- MAIN
main =
    Browser.element
         { init = init
         , update = update
         , subscriptions = subscriptions
         , view = view
         }
 
-- MODEL
 
type alias Model =
    { characterPositionX : Int
    , characterPositionY : Int
    , itemPositionX : Int
    , itemPositionY : Int
    }
 
initialModel : Model
initialModel =
    { characterPositionX = 50
    , characterPositionY = 300
    , itemPositionX = 500
    , itemPositionY = 300

    }
 
init : () -> ( Model, Cmd Msg )
init _ =
    ( initialModel, Cmd.none )
 
-- UPDATE
 
type Msg
    = KeyDown String
    | NoOp
 
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        KeyDown key ->
             ( { model | characterPositionX = model.characterPositionX + 15 }, Cmd.none )
        NoOp ->
            ( model, Cmd.none )
 
-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Browser.Events.onKeyDown (Decode.map KeyDown keyDecoder)
        ]

keyDecoder : Decode.Decoder String
keyDecoder =
    Decode.field "key" Decode.string

-- VIEW

view : Model -> Html Msg
view model =
    div []
        [ viewGame model]
  
  
viewGame : Model -> Svg Msg
viewGame model =
    svg [ version "1.1", width "600", height "400" ]
        [ viewGameWindow
        , viewGameSky
        , viewGameGround
        , viewCharacter model
        , viewItem model
        ]
 
viewGameWindow : Svg Msg
viewGameWindow =
    rect
        [ width "600"
        , height "400"
        , fill "none"
        , stroke "black"
        ]
        []

viewGameSky : Svg Msg
viewGameSky =
    rect
        [ x "0"
        , y "0"
        , width "600"
        , height "300"
        , fill "#4b7cfb"
        ]
        []
 
viewGameGround : Svg Msg
viewGameGround =
    rect
        [ x "0"
        , y "300"
        , width "600"
        , height "100"
        , fill "green"
        ]
        []

viewCharacter : Model -> Svg Msg
viewCharacter model =
    image
        [ xlinkHref "../images/adventurer-idle-03.png"
        , x (String.fromInt model.characterPositionX)
        , y (String.fromInt model.characterPositionY)
        , width "50"
        , height "50"
        ]
        []

viewItem : Model -> Svg Msg
viewItem model =
    image
        [ xlinkHref "/images/coin.svg"
        , x (String.fromInt model.itemPositionX)
        , y (String.fromInt model.itemPositionY)
        , width "20"
        , height "20"
        ]
        []

