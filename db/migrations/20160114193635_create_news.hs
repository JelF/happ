{-# LANGUAGE OverloadedStrings #-}

import Database.PostgreSQL.Migrations
import Database.PostgreSQL.Simple

up :: Connection -> IO ()
up = migrate $
  create_table "news"
    [column "id" "SERIAL PRIMARY KEY"
    ,column "title" "VARCHAR NOT NULL"
    ,column "short" "TEXT"
    ,column "content" "TEXT"]

down :: Connection -> IO ()
down = migrate $ drop_table "news"

main :: IO ()
main = defaultMain up down
