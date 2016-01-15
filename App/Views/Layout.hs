{-# LANGUAGE OverloadedStrings #-}

module App.Views.Layout (
   appLayout
  ,errrorLayout
) where

import Text.Blaze.Html5 ((!))
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A

appLayout :: H.Html -> H.Html
appLayout content =
  H.html $ do
    H.head $ do
      H.title "Happ testing engine!"
      H.link ! A.rel "stylesheet" ! A.href "/assets/application.css"
    H.body $
      H.div ! A.id "wrapper" $ do
        H.div ! A.id "page__header" $ ""
        H.div ! A.id "page__content" $ content
        H.div ! A.id "page__footer" $
          H.a ! A.href "../" $ "back"

errrorLayout :: H.ToMarkup a => a -> H.Html
errrorLayout string = appLayout $ H.toHtml string
