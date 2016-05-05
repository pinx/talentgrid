module TalentGrid.Model where

import TalentGrid.Auth.Model as Auth

type alias Model =
  { user : Auth.User 
  , facebookAuth : Auth.FacebookAuth
  }

initialModel : Model
initialModel =
  { user = Auth.initialUser 
  , facebookAuth = Auth.initialFacebookAuth
  }
