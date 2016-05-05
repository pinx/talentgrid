module TalentGrid where

import Html exposing (..)
import StartApp
import Signal exposing (Address)
import Effects exposing (Effects, Never)
import Task

import TalentGrid.Action as Action exposing (..)
import TalentGrid.Model as Model exposing (Model, initialModel)
import TalentGrid.Update as Update exposing (update, init)
import TalentGrid.View as View exposing (view)

import TalentGrid.Auth.Model as Auth

app : StartApp.App Model
app = StartApp.start
  { init = Update.init
  , update = Update.update
  , view = View.view
  , inputs = [ loginAction ]
  }

main : Signal Html
main =
  app.html


-- Signals
loginAction : Signal Action
loginAction = 
  Signal.map FacebookAuth (Debug.log "login" facebookLogin)


-- Ports
port tasks : Signal (Task.Task Never ())
port tasks =
    app.tasks

port facebookLogin : Signal Auth.FacebookAuth
