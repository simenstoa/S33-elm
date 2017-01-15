module App exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (..)
import String


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


type Type
    = OG
    | FG


type Msg
    = Change Type String
    | CalculateAlcVol


type alias Model =
    { originalGravity : Float
    , finalGravity : Float
    , alcVol : Float
    }


model : Model
model =
    { originalGravity = 0, finalGravity = 0, alcVol = 0 }


parseFloat : String -> Float
parseFloat string =
    string |> String.toFloat |> Result.withDefault 0


calcAlcVol : Float -> Float -> Float
calcAlcVol og fg =
    ((og - fg) / 0.75) * 100


sliceAndConcat : List String -> String
sliceAndConcat list =
    let
        head =
            List.head list
                |> Maybe.withDefault ""

        tail =
            List.drop 1 list
                |> List.head
                |> Maybe.withDefault ""
                |> String.toList
                |> List.take 2
                |> String.fromList
    in
        head ++ "." ++ tail


floatToFixedString : Float -> String
floatToFixedString float =
    float
        |> toString
        |> String.split "."
        |> sliceAndConcat


update : Msg -> Model -> ( Model, Cmd a )
update msg model =
    case msg of
        Change gravityType string ->
            case gravityType of
                OG ->
                    ( { model | originalGravity = parseFloat string }, Cmd.none )

                FG ->
                    ( { model | finalGravity = parseFloat string }, Cmd.none )

        CalculateAlcVol ->
            ( { model | alcVol = calcAlcVol model.originalGravity model.finalGravity }, Cmd.none )


init : ( Model, Cmd a )
init =
    ( model, Cmd.none )


myH3 : Model -> Html a
myH3 model =
    if model.alcVol > 0 then
        h3 [] [ text (floatToFixedString model.alcVol) ]
    else
        div [] []


view : Model -> Html Msg
view model =
    div [ class "main" ]
        [ h1 [ class "header" ]
            [ span [ class "header-text-large" ] [ text "S 3 3" ]
            , span [ class "header-text-medium" ] [ text "KJELLERBRYGGERI" ]
            ]
        , section [ class "section" ]
            [ section [ class "calculator-section" ]
                [ h2 [] [ text "Regn ut ABV" ]
                , myH3 model
                , input [ placeholder "Original gravity", onInput (Change OG) ] [ text (toString model.originalGravity) ]
                , input [ placeholder "Final gravity", onInput (Change FG) ] [ text (toString model.finalGravity) ]
                , button [ onClick CalculateAlcVol ] [ text "Regn ut alc%" ]
                ]
            ]
        ]
