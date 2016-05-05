module TalentGrid.Action where

import Http
import TalentGrid.Auth.Model as Auth exposing (User)

type Action
  = FacebookAuth Auth.FacebookAuth
  | Login Auth.User --(Result Http.Error Auth.User)
--  | ShowProfile String

