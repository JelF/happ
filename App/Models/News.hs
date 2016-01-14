{-# LANGUAGE DeriveGeneric #-}

module App.Models.News (
  News
  ,newsId
  ,newsTitle
  ,newsShort
  ,newsContent
) where

import Database.PostgreSQL.ORM
import GHC.Generics
import Data.Text
import Config.Connection

data News = News {
  newsId :: DBKey,
  newsTitle :: Text,
  newsShort :: Text,
  newsContent :: Text
} deriving Generic

instance Model News
