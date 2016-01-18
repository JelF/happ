{-# OPTIONS_GHC -fno-warn-unused-binds #-}


module Happ.Routing.RouteSpec (spec) where

import Data.Text (pack)
import Test.Hspec
import Test.QuickCheck
import Happstack.Server

import Happ.Routing.Route
import Happ.Routing.SpecHelpers ()


-- `main` is here so that this module can be run from GHCi on its own.  It is
-- not needed for automatic spec discovery.
main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "getMethod" $ do
    it "converts Nothing to GET" $
      getMethod (Route Nothing []) `shouldBe` GET
    it "accepts JUST" $ do
      getMethod (Route (Just GET) []) `shouldBe` GET
      getMethod (Route (Just POST) []) `shouldBe` POST

  describe "toPath" $ do
    it "saves only arg" $
      toPath "news" `shouldBe` "news"
    it "intercalates args" $
      toPath (Route Nothing ["news", "1"]) `shouldBe` "news/1"

  describe "Route" $ do
    it "is an instance of Eq" $ property $
      \ x -> x == (x :: Route)
    it "is an instance of Show" $ do
      -- Do not remove covered lines, because we did not check that it calls
      -- getMethod and toPath correctly
      show (Route Nothing []) `shouldBe` "GET"
      show (Route (Just GET) []) `shouldBe` "GET"
      show (Route (Just POST) []) `shouldBe` "POST"
      show (Route (Just GET) ["news"]) `shouldBe` "GET news"
      show (Route (Just GET) ["news", "1"]) `shouldBe` "GET news/1"
    describe "is an instance of Ord" $ do
      it "obeys EQ => eq law" $ property $
        \ x y ->
          let _ = (x :: Route, y :: Route)
          in (compare x y == EQ) == (x == y)
      it "is reflexive" $ property $
        \ x -> compare x (x :: Route) == EQ

  describe "toRoute" $ do
    it "converts Route" $ property $
      \x -> toRoute x == (x :: Route)
    it "converts String" $ property $
      \x -> toRoute x == Route Nothing [x :: String]
    it "converts Text" $ property $
      \x -> toRoute (pack x) == Route Nothing [x :: String]
    it "converts Method" $ property $
      \x -> toRoute x == Route (Just (x :: Method)) []

  describe "rc" $ do
    it "applies method to string" $ property $
      \x y ->
        let _ = x :: Method
            _ = y :: String
        in x `rc` y == Route (Just x) [y]

    it "concats two strings" $ property $
      \x y ->
        let _ = x :: String
            _ = y :: String
        in x `rc` y == Route Nothing [x, y]

    it "uses last method met" $ property $
      \x y ->
        let _ = x :: Method
            _ = y :: Method
        in x `rc` y == Route (Just y) []
