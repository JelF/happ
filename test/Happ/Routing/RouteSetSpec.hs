{-# OPTIONS_GHC -fno-warn-unused-binds #-}


module Happ.Routing.RouteSetSpec (spec) where

-- import Data.Text (pack)
import Data.HashMap as M
import Test.Hspec
-- import Test.QuickCheck
-- import Happstack.Server
--
import Happ.Routing.Route
import Happ.Routing.RouteSet
import Happ.Routing.SpecHelpers ()


-- `main` is here so that this module can be run from GHCi on its own.  It is
-- not needed for automatic spec discovery.
main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  let e = RouteSet empty

  describe "toRoutes" $ do
    it "empty" $
      toRoutes e `shouldBe` []
    it "simple" $
      let m = singleton "news" e `union` singleton "users" e
      in toRoutes (RouteSet m) `shouldBe` [toRoute "news", toRoute "users"]
    it "ordered" $
      let m = singleton "users" e `union` singleton "news" e
      in toRoutes (RouteSet m) `shouldBe` [toRoute "news", toRoute "users"]
    it "nested" $
      let m = RouteSet $ singleton "news" e
          m' = RouteSet $ singleton "admin" m
      in toRoutes m' `shouldBe` ["admin" `rc` "news"]
    it "leafy" $
      let m = RouteSet $ singleton "news" e `union` singleton "users" e
          m' = RouteSet $ singleton "admin" m
      in toRoutes m' `shouldBe` ["admin" `rc` "news", "admin" `rc` "users"]

  describe "Routes" $
    describe "is an isntance of Show" $ do
      it "empty" $
        show e `shouldBe` "Empty RouteSet"
      it "contains 2 elements" $
        let m = singleton "news" e `union` singleton "users" e
        in show (RouteSet m) `shouldBe` "GET news\nGET users"
