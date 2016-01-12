{-# LANGUAGE OverloadedStrings #-}

module App.Views.Layout (appLayout)
where

import Text.Blaze.Html5 ((!))
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A
import Happstack.Lite (toResponse, Response)

appLayout :: H.Html -> Response
appLayout content = toResponse $
  H.html $ do
    H.head $ do
      H.title "Happ testing engine!"
      H.link ! A.rel "stylesheet" ! A.href "assets/application.css"
    H.body $ do
      H.div ! A.id "wrapper" $ do
         content
         H.a ! A.href "/" $ "home"
