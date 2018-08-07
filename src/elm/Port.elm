port module Port exposing (initializeMap, moveMap, mapMoved)

import Map


-- OUTGOING


port initializeMap : Map.JsObject -> Cmd msg


port moveMap : Map.JsObject -> Cmd msg



-- INCOMING


port mapMoved : (Map.JsObject -> msg) -> Sub msg
