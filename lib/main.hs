module Main where

import Happstack.Server
import qualified App.Views.Home
import qualified App.Controllers.News
import System.Process (callCommand)
import Control.Monad (msum)

main :: IO ()
main = do
  callCommand "gulp styles"
  print "Started!"
  simpleHTTP nullConf happ

happ :: ServerPart Response
happ = msum
  [ dir "assets" assets
  , dir "static" static
  , App.Views.Home.index
  , App.Controllers.News.routes ]

assets :: ServerPart Response
assets =  serveDirectory DisableBrowsing [] "public/assets"

static :: ServerPart Response
static =  serveDirectory DisableBrowsing [] "public"
