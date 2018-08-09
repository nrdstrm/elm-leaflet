module Main exposing (main)

import Map
import Port
import Html exposing (Html, div, h1, p, text, ul, li)
import Html.Attributes exposing (id, attribute)
import Html.Events exposing (onClick)


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
    , selectedCity : City
    }


init : ( Model, Cmd Msg )
init =
    ( { title = "Map"
      , map = Map.init
      , selectedCity = defaultCity
      }
    , Map.init
        |> Map.toJsObject
        |> Port.initializeMap
    )



-- UPDATE


type Msg
    = NoOp
    | OnMapMoved Map.JsObject
    | SelectCity City


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        OnMapMoved { lat, lng } ->
            ( { model | map = Map.modify lat lng model.map }
            , Cmd.none
            )

        SelectCity city ->
            ( { model | selectedCity = city }, Port.moveMap city.location )



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
        , renderCities model cities
        ]


type alias City =
    { name : String
    , location :
        { lat : Float
        , lng : Float
        }
    }


cities : List City
cities =
    [ City "Jönköping" { lat = 57.78145, lng = 14.15618 }
    , City "Huskvarna" { lat = 57.78596, lng = 14.30214 }
    , City "New York" { lat = 40.71427, lng = -74.00597 }
    , City "London" { lat = 51.51279, lng = -0.09184 }
    ]


defaultCity : City
defaultCity =
    Maybe.withDefault
        (City "Jönköping" { lat = 57.78145, lng = 14.15618 })
        (List.head cities)


renderCities : Model -> List City -> Html Msg
renderCities model list =
    list
        |> List.map
            (\l ->
                li
                    [ attribute "data-selected" (toString (l == model.selectedCity))
                    , onClick (SelectCity l)
                    ]
                    [ text l.name ]
            )
        |> ul []
