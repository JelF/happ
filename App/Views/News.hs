{-# LANGUAGE OverloadedStrings #-}

module App.Views.News (
   index
  ,App.Views.News.show
) where

import Text.Blaze.Html5 ((!), toHtml)
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A

import Data.Monoid
import Data.String

import App.Models.News (News)
import qualified App.Models.News as News
import App.Views.Layout (appLayout)

index :: [News] -> H.Html
index news = appLayout $ toHtml $ do
  H.h1 ! A.class_ "page__title" $ "News"
  H.div ! A.class_ "news-list" $
    mconcat $ map cell news
  where
    cell :: News -> H.Html
    cell news' =
      H.div ! A.class_ "news_cell" $ do
        H.div ! A.class_ "news__title" $ toHtml $ News.title news'
        H.div ! A.class_ "news__short" $ do
          H.span $ toHtml $ News.short news'
          H.a ! A.href (newsShowPath news') ! A.class_ "news__show-more" $ "Show more ..."
    newsShowPath :: News -> H.AttributeValue
    newsShowPath = fromString . (++ "/") . Prelude.show . News.id

show :: News -> H.Html
show news = appLayout $ toHtml $
  H.div ! A.class_ "news_standalone" $ do
    H.h1 ! A.class_ "news__title" $ toHtml $ News.title news
    H.div ! A.class_ "news__content" $ News.content news
