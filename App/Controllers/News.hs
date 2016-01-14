module App.Controllers.News (
   routes
  -- ,index
  -- ,show
) where

import Happstack.Server
import Control.Monad
import App.Models.News

routes :: ServerPart Response
routes = msum
  [ok $ toResponse "123"]
