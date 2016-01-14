{-# LANGUAGE DeriveGeneric #-}

module App.Models.News (
  User
) where

import Database.PostgreSQL.ORM.Model

data User = User {

} deriving Generic
