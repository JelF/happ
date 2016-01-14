{-# LANGUAGE OverloadedStrings #-}

module App.Views.Home (index)
where

import Happstack.Server
import Text.Blaze.Html5
import App.Views.Layout

index :: ServerPart Response
index = ok $ appLayout $ do
  h1 "Happ test!"
  p "It is good for you!"
