module AlcCalc exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (..)
import String


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
    { originalGravity = 1.05, finalGravity = 1.01, alcVol = calcAlcVol 1.05 1.01 }


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


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change gravityType string ->
            case gravityType of
                OG ->
                    { model | originalGravity = parseFloat string }

                FG ->
                    { model | finalGravity = parseFloat string }

        CalculateAlcVol ->
            { model | alcVol = calcAlcVol model.originalGravity model.finalGravity }


myH3 : Model -> Html Msg
myH3 model =
    if model.alcVol > 0 then
        h3 [] [ text (floatToFixedString model.alcVol) ]
    else
        div [] []


view : Model -> Html Msg
view model =
    section [ class "calculator-section" ]
        [ h2 [] [ text "Regn ut ABV" ]
        , myH3 model
        , input [ placeholder "Original gravity", onInput (Change OG) ] [ text (toString model.originalGravity) ]
        , input [ placeholder "Final gravity", onInput (Change FG) ] [ text (toString model.finalGravity) ]
        , button [ onClick CalculateAlcVol ] [ text "Regn ut alc%" ]
        ]
