module App.Controllers.News (routes) where

import Happstack.Server
import Control.Monad
import Control.Monad.IO.Class
import Text.Read
import Database.PostgreSQL.ORM

import Config.Connection (connection)
import App.Models.News (News)
import qualified App.Views.News as View
import App.Views.Layout (errrorLayout)

routes :: ServerPart Response
routes = msum
  [path toShow
  ,toIndex]

toShow :: String -> ServerPart Response
toShow = toShow' . readEither
  where
    toShow' :: Either String (DBRef News) -> ServerPart Response
    toShow' (Left errMsg) = resp 400 $ toResponse $ errrorLayout errMsg
    toShow' (Right newsId) = getNews newsId >>= response
    getNews :: DBRef News -> ServerPart (Maybe News)
    getNews newsId = liftIO $ connection >>=  flip findRow newsId
    response :: Maybe News -> ServerPart Response
    response Nothing = resp 404 $ toResponse $ errrorLayout "Not found"
    response (Just x)  = ok $ toResponse $ View.show x

toIndex :: ServerPart Response
toIndex = do
  news <- liftIO $ connection >>= findAll :: ServerPart [News]
  ok $ toResponse $ View.index news
