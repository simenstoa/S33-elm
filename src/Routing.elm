module Routing exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (..)


calcPath : String
calcPath =
    "kalkulatorer"


picturesPath : String
picturesPath =
    "etiketter"


type Route
    = AlcCalcRoute
    | PictureRoute
    | NotFoundRoute


routeToString : Route -> String
routeToString route =
    case route of
        AlcCalcRoute ->
            calcPath

        PictureRoute ->
            picturesPath

        NotFoundRoute ->
            ""


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map PictureRoute top
        , map PictureRoute (s picturesPath)
        , map AlcCalcRoute (s calcPath)
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parsePath matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute
