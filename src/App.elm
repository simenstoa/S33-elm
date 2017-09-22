module App exposing (..)

import AlcCalc
import Etiketter
import Menu
import Html exposing (..)
import Html.Attributes exposing (..)
import Navigation exposing (Location)
import Routing
import Messages exposing (..)


type alias Model =
    { alcCalc : AlcCalc.Model
    , route : Routing.Route
    }


initialModel : Routing.Route -> Model
initialModel route =
    { alcCalc = AlcCalc.initialModel, route = route }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CalcMsg calcMsg ->
            ( { model | alcCalc = AlcCalc.update calcMsg model.alcCalc }, Cmd.none )

        ChangeLocation path ->
            ( model, Navigation.newUrl path )

        OnLocationChange location ->
            ( { model | route = Routing.parseLocation location }, Cmd.none )


page : Model -> Html Msg
page model =
    case model.route of
        Routing.AlcCalcRoute ->
            AlcCalc.view model.alcCalc |> Html.map CalcMsg

        Routing.PictureRoute ->
            Etiketter.view

        Routing.NotFoundRoute ->
            div [] [ text "Not Found" ]


view : Model -> Html Msg
view model =
    div [ class "main" ]
        [ h1 [ class "header" ]
            [ span [ class "header-text-large" ] [ text "S 3 3" ]
            , span [ class "header-text-medium" ] [ text "KJELLERBRYGGERI" ]
            ]
        , (Menu.navBar model.route)
        , section [ class "section" ] [ page model ]
        ]
