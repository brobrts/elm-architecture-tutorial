module CounterPair where

import Counter
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- MODEL

type alias Model =
    { topCounter : Counter.Model
    , bottomCounter : Counter.Model
    }

-- notice how the 'return val' of the expression
-- is implicitly a model in code and explicit
-- in the type def
init : Int -> Int -> Model
init top bottom =
    { topCounter = Counter.init top
    , bottomCounter = Counter.init bottom
    }


-- UPDATE

type Action
    = Reset
    | Top Counter.Action
    | Bottom Counter.Action


-- 1) mystery operator act ->?
-- must be called by the 'loop' to return the updated
-- model for rendering.
-- 2) 'Top' is a noun, yet it is passed in as an action!!
-- ok for a small example, but could cause some cognative
-- dissonance when things get large.
-- 3) syntax:  model | topCounter ...same as Model.topCounter?
--  topCounter = Counter.update act model.topCounter

update : Action -> Model -> Model
update action model =
  case action of
    Reset -> init 0 0

    Top act ->
      { model |
          topCounter = Counter.update act model.topCounter
      }

    Bottom act ->
      { model |
          bottomCounter = Counter.update act model.bottomCounter
      }


-- VIEW
-- does this "Signal.Address Action", constitute one parameter?
-- 


view : Signal.Address Action -> Model -> Html
view address model =
  div []
    [ Counter.view (Signal.forwardTo address Top) model.topCounter
    , Counter.view (Signal.forwardTo address Bottom) model.bottomCounter
    , button [ onClick address Reset ] [ text "RESET" ]
    ]
