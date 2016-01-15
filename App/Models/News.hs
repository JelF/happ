{-# LANGUAGE DeriveGeneric #-}

module App.Models.News (
  News
  ,App.Models.News.id
  ,App.Models.News.title
  ,App.Models.News.short
  ,App.Models.News.content
) where

import Database.PostgreSQL.ORM
import GHC.Generics
import Data.Text

data News = News {
  id :: DBKey,
  title :: Text,
  short :: Text,
  content :: Text
} deriving Generic

instance Model News
