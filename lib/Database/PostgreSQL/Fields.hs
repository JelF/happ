{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module Database.PostgreSQL.Fields ()
where

import Database.PostgreSQL.Simple.FromField
import Database.PostgreSQL.Simple.ToField
import Control.Applicative
import Text.Blaze.Html5
import Text.Blaze.Html.Renderer.Text
import Data.Text.Encoding
import Database.PostgreSQL.Simple.TypeInfo.Static as TI

instance FromField Html where
  fromField f mdata =
      if typeOid f /= typoid TI.text
        then returnError Incompatible f ""
        else case mdata of
               Nothing  -> returnError UnexpectedNull f ""
               Just dat -> pure $ preEscapedText $ decodeUtf8 dat

instance ToField Html where
  toField = toField . renderHtml
