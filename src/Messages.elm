module Messages exposing (..)

import AlcCalc
import Navigation exposing (Location)


type Msg
    = CalcMsg AlcCalc.Msg
    | ChangeLocation String
    | OnLocationChange Location
