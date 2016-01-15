{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -fno-warn-unused-do-bind #-}

module Config.Connection (
  connection
) where

import Control.Monad
import Data.ByteString.Char8
import Data.Maybe
import Database.PostgreSQL.Simple
import System.Environment

connection :: IO Connection
connection = do
  psqlStr <- liftM (fromJust . lookup "DATABASE_URL") getEnvironment
  conn <- connectPostgreSQL $ pack psqlStr
  execute_ conn "SET lc_messages TO 'en_US.UTF-8';"
  return conn
