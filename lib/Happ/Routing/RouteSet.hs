-- RouteSet is a data structure that contains defined routes
--   and helps to access it
module Happ.Routing.RouteSet (
    RouteSet (RouteSet)
  , toRoutes
) where

import Control.Monad
import Control.Monad.Writer
import Control.Applicative
import Data.HashMap as M
import Data.List (intercalate)

import Happ.Routing.Route

data RouteSet = RouteSet (Map String RouteSet)

instance Show RouteSet where
  show =  show' . fmap show . toRoutes
    where
      show' [] = "Empty RouteSet"
      show' x = intercalate "\n" x

content_ :: RouteSet -> Map String RouteSet
content_ (RouteSet x) = x

toRoutes :: RouteSet -> [Route]
toRoutes = toRoutes' . assocs . content_
  where
    toRoutes' :: [(String, RouteSet)] -> [Route]
    toRoutes' [] = []
    toRoutes' [(s, rs)] | M.null $ content_ rs  = [toRoute s]
                        | otherwise             = (s `rc`) <$> toRoutes rs
    toRoutes' (x:xs) = toRoutes' [x] ++ toRoutes' xs
