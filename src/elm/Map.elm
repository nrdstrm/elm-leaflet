module Map exposing (Model, JsObject, init, modify, toJsObject)

-- hide model implementation


type Model
    = Internal
        { lat : Float
        , lng : Float
        }


init : Model
init =
    Internal
        { lat = 57.7661007001215
        , lng = 14.17026311159134
        }


modify : Float -> Float -> Model -> Model
modify lat lng (Internal model) =
    Internal
        { model | lat = lat, lng = lng }


type alias JsObject =
    { lat : Float
    , lng : Float
    }


toJsObject : Model -> JsObject
toJsObject (Internal model) =
    { lat = model.lat
    , lng = model.lng
    }
