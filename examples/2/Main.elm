
import CounterPair exposing (init, update, view)
import StartApp.Simple exposing (start)

-- StartApp is a wrapper around Signals
main =
  start
    { model = init 0 0
    , update = update
    , view = view
    }
