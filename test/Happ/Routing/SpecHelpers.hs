{-# OPTIONS_GHC -fno-warn-orphans #-}

module Happ.Routing.SpecHelpers ()
where

import Control.Monad
import Happstack.Server
import Test.QuickCheck

import Happ.Routing.Route

instance Arbitrary Method where
  arbitrary = elements [GET, POST, PUT, DELETE]

instance Arbitrary Route where
  arbitrary = liftM2 Route arbitrary (listOf arbitrary)
