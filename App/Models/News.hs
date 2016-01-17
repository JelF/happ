{-# LANGUAGE DeriveGeneric #-}

module App.Models.News (
  News
  ,App.Models.News.id
  ,App.Models.News.title
  ,App.Models.News.short
  ,App.Models.News.content
) where

import Database.PostgreSQL.ORM
import Database.PostgreSQL.Fields ()
import GHC.Generics
import Data.Text
import Text.Blaze.Html5

data News = News {
  id :: DBKey,
  title :: Text,
  short :: Text,
  content :: Html
} deriving Generic

instance Model News
