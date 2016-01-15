module Main where

import Happstack.Server
import qualified App.Controllers.News
import Control.Monad (msum)

main :: IO ()
main = simpleHTTP nullConf happ

happ :: ServerPart Response
happ = msum
  [ dir "assets" assets
  , dir "static" static
  , dir "news" App.Controllers.News.routes
  , seeOther "/news/" $ toResponse "/news/" ]

assets :: ServerPart Response
assets =  serveDirectory DisableBrowsing [] "public/assets"

static :: ServerPart Response
static =  serveDirectory DisableBrowsing [] "public"
