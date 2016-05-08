module TalentGrid.Auth.Model where

import Http exposing (url)
import Json.Decode exposing (Decoder, (:=))

type alias User = 
  { email : String
  , token : String
  , authenticated : Bool
  }

type alias FacebookAuth =
  { id : String
  , name : String
  , email : String
  , timezone : Int
  , facebook_token : String
  }

initialUser : User
initialUser =
  { email = ""
  , token = ""
  , authenticated = False
  }

initialFacebookAuth : FacebookAuth
initialFacebookAuth =
  { id = ""
  , name = ""
  , email = ""
  , timezone = 0
  , facebook_token = ""
  }

loginWithFacebookUrl : FacebookAuth -> String
loginWithFacebookUrl fbAuth =
  Http.url "http://localhost:4000/auth/facebook" (authParams fbAuth)

authParams : FacebookAuth -> List (String, String)
authParams fbAuth =
  [ ("id", fbAuth.id)
  , ("email", fbAuth.email)
  , ("facebook_token", fbAuth.facebook_token)
  ]


userDecoder : Json.Decode.Decoder User
userDecoder =
  Json.Decode.at ["data"] (
    Json.Decode.object3 User
      ("email" := Json.Decode.string)
      ("token" := Json.Decode.string)
      ("authenticated" := Json.Decode.bool)
  )
