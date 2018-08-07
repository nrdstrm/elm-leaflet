module Main exposing (main)

import Map
import Port
import Html exposing (Html, div, h1, p, text)
import Html.Attributes exposing (id)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { title : String
    , map : Map.Model
    }


init : ( Model, Cmd Msg )
init =
    ( { title = "Map"
      , map = Map.init
      }
    , Map.init
        |> Map.toJsObject
        |> Port.initializeMap
    )



-- UPDATE


type Msg
    = NoOp
    | OnMapMoved Map.JsObject


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        OnMapMoved { lat, lng } ->
            ( { model | map = Map.modify lat lng model.map }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Port.mapMoved OnMapMoved



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text model.title ]
        , p [] [ text <| (toString <| Map.toJsObject model.map) ]
        , div []
            [ div [ id "map" ] []
            ]
        ]
