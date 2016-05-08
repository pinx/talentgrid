module TalentGrid.Update where

import Effects exposing (Effects, Never)
import Http exposing (post)
import Task exposing (Task)

import TalentGrid.Action exposing (..)
import TalentGrid.Model as Model exposing (Model)
import TalentGrid.Auth.Model as Auth


initialLoadEffects : Auth.User -> Effects Action
initialLoadEffects user =
  if user.authenticated then
    Effects.none
--    showProfile user
  else
    Effects.none

-- showProfile : User -> Effects Action
-- showProfile user =
--   getProfile user |> Effects.map ShowProfile

init : (Model, Effects Action)
init =
  (Model.initialModel, Effects.none)


update : Action -> Model -> (Model, Effects Action)
update action model =
  let a = Debug.log "update" action
  in
      case action of
        FacebookAuth fbAuth -> 
          ({ model | facebookAuth = fbAuth }, loginWithFacebook fbAuth)

        Login result ->
          let
              user = Result.withDefault Auth.initialUser result
          in
              ({ model | user = user }, initialLoadEffects user)


-- Effects
-- Send Facebook token to our backend
-- We expect a new or existing user
loginWithFacebook : Auth.FacebookAuth -> Effects Action
loginWithFacebook fbAuth =
  Http.get Auth.userDecoder (Auth.loginWithFacebookUrl fbAuth)
  |> Task.toResult
  |> Task.map Login
  |> Effects.task


-- taskToRecord : Task x a -> Maybe a
-- taskToRecord result =
--   case result of
--     Ok response ->
--       Just response
--     Err error ->
--       let
--           errorMessage = Debug.log "resultToRecord error" error
--       in
--          Nothing

