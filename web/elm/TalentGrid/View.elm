module TalentGrid.View where

import Html exposing (..)
import Signal exposing (Address)
import Effects exposing (Effects, Never)

import TalentGrid.Action exposing (..)
import TalentGrid.Model exposing (Model)

view : Address Action -> Model -> Html
view address model =
  div 
    []
    [ text ("Welcome " ++ (toString model)) ]
