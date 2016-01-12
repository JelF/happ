module Main where

import Happstack.Lite
import qualified App.Views.Home
import System.Process (callCommand)

main = do
  callCommand "gulp styles"
  print "Started!"
  serve Nothing happ

happ :: ServerPart Response
happ = msum
  [ dir "assets" assets
  , dir "static" static
  , App.Views.Home.index ]

assets :: ServerPart Response
assets =  serveDirectory DisableBrowsing [] "public/assets"

static :: ServerPart Response
static =  serveDirectory DisableBrowsing [] "public"
