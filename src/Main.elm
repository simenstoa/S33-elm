module Main exposing (..)

import App exposing (..)
import Navigation exposing (Location, program)
import Routing
import Menu
import Messages exposing (..)


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( initialModel currentRoute, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    program OnLocationChange { view = view, init = init, update = update, subscriptions = subscriptions }
