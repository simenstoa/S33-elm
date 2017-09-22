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


type alias Model =
    { originalGravity : String
    , finalGravity : String
    }


initialModel : Model
initialModel =
    { originalGravity = "1.050", finalGravity = "1.010" }


parseFloat : String -> Float
parseFloat string =
    string |> String.toFloat |> Result.withDefault 0


calcAlcVol : String -> String -> Float
calcAlcVol og fg =
    let
        parsedOG =
            parseFloat og

        parsedFG =
            parseFloat fg
    in
        if (parsedFG == 0 || parsedOG == 0) then
            0
        else
            ((parsedOG - parsedFG) / 0.75) * 100


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
                    { model | originalGravity = string }

                FG ->
                    { model | finalGravity = string }


viewAlcVol : String -> String -> Html Msg
viewAlcVol og fg =
    let
        alcVol =
            calcAlcVol og fg
    in
        if alcVol > 0 then
            div [] [ text ("=> " ++ (floatToFixedString alcVol) ++ "%") ]
        else
            text ""


view : Model -> Html Msg
view model =
    section [ class "calculator-section" ]
        [ h2 [] [ text "Regn ut ABV" ]
        , div [ class "calculator" ]
            [ div [] [ text "OG:" ]
            , input
                [ placeholder "Original gravity"
                , onInput (Change OG)
                , value model.originalGravity
                ]
                []
            , div [] [ text "FG:" ]
            , input
                [ placeholder "Final gravity"
                , onInput (Change FG)
                , value model.finalGravity
                ]
                []
            , viewAlcVol model.originalGravity model.finalGravity
            ]
        ]
