{-# LANGUAGE OverloadedStrings #-}

module Config.Connection (
  connection
) where

import Database.PostgreSQL.Simple
connection :: IO Connection
connection = connectPostgreSQL
  "host='localhost' port=5432 dbname='happ' user='jelf'"
