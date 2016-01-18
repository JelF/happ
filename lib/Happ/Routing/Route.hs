{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}

module Happ.Routing.Route (
    Route(Route)
  , ToRoute
  , toRoute
  , toPath
  , getMethod
  , rc
) where

import Data.List
import Data.Maybe
import Data.Text (Text, unpack)
import Happstack.Server (Method(GET))

data Route = Route (Maybe Method) [String] deriving (Eq)

instance Show Route where
  show route = show' (show $ getMethod route) (toPath route)
    where
      show' x [] = x
      show' x ys = x ++ " " ++ ys

instance Ord Route where
  compare (Route m1 a) (Route m2 b) = compare' (m1 `compare` m2) (a `compare` b)
    where
      compare' x EQ = x
      compare' _ x  = x

class ToRoute a where
  toRoute :: a -> Route

instance ToRoute Route where
  toRoute = id

instance ToRoute String where
  toRoute = Route Nothing . return

instance ToRoute Text where
  toRoute = toRoute . unpack

instance ToRoute Method where
  toRoute = flip Route [] . Just

getMethod :: Route -> Method
getMethod (Route x _) = fromMaybe GET x

toPath :: ToRoute a => a -> String
toPath = toPath' . toRoute
  where toPath' (Route _ ys) = intercalate "/" ys

rc :: (ToRoute a) => (ToRoute b) => a -> b -> Route
rc x y = rc' (toRoute x) (toRoute y)
  where
    rc' (Route _ x') (Route (Just method) y') = Route (Just method) (x' ++ y')
    rc' (Route method x') (Route Nothing y') = Route method $ x' ++ y'
