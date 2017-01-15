module Main exposing (..)

import Html exposing (program)
import App exposing (..)


main : Program Never Model Msg
main =
    program { view = view, init = init, update = update, subscriptions = subscriptions }
