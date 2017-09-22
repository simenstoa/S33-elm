module Menu exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick, onWithOptions)
import Json.Decode as Decode
import Routing
import Messages exposing (..)


activeClassName : String -> String -> String
activeClassName path currentPath =
    if path == currentPath then
        " active"
    else
        ""


onLinkClick : Msg -> Attribute Msg
onLinkClick message =
    let
        options =
            { stopPropagation = False
            , preventDefault = True
            }
    in
        onWithOptions "click" options (Decode.succeed message)


navLink : String -> String -> Html Msg
navLink path currentPath =
    a
        [ class ("navlink" ++ activeClassName path currentPath)
        , href path
        , onLinkClick (ChangeLocation path)
        ]
        [ text path ]


navBar : Routing.Route -> Html Msg
navBar currentRoute =
    nav [ class "navbar" ]
        [ div [ class "navlinkWrapper" ]
            [ navLink Routing.picturesPath <| Routing.routeToString currentRoute
            , navLink Routing.calcPath <| Routing.routeToString currentRoute
            ]
        ]
