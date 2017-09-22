module Etiketter exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, src)


view : Html msg
view =
    section [ class "image-section" ]
        [ img [ src "/images/treningspils.png" ]
            []
        ]
