module TalentGrid.Action where

import Http
import TalentGrid.Auth.Model as Auth exposing (User)

type Action
  = FacebookAuth Auth.FacebookAuth
  | Login (Result Http.Error Auth.User)
--  | ShowProfile String
