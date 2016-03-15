module Counter (Model, init, Action, update, view) where

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)


-- MODEL

type alias Model = Int


init : Int -> Model
init count = Debug.log "init count: " count


-- UPDATE

type Action = Increment | Decrement

-- is it safe to call this our event handler?
-- implicitly registered with onClick...
-- tutorial: 
-- 'Every event handler in our view function reports to a particular address'
-- 'The StartApp package monitors all the messages coming in to this address 
--  and feeds them into the update function.'
--  After the model is updated, elm takes care of rendering it.  
--  ...kind of like angular's digest cycle???
 
update : Action -> Model -> Model
update action model =
  case action of
    Increment ->
      Debug.log "Increment: " model + 1

    Decrement ->
      Debug.log "Decrement: " model - 1


-- VIEW
-- 2 or 3 params?
view : Signal.Address Action -> Model -> Html
view address model =
  div []
    [ button [ onClick address Decrement ] [ text "-" ]
    , div [ countStyle ] [ text (toString model) ]
    , button [ onClick address Increment ] [ text "+" ]
    ]


countStyle : Attribute
countStyle =
  style
    [ ("font-size", "20px")
    , ("font-family", "monospace")
    , ("display", "inline-block")
    , ("width", "50px")
    , ("text-align", "center")
    ]
