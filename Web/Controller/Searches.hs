module Web.Controller.Searches where

import Web.Controller.Prelude

instance Controller SearchesController where
    action ShowSearchAction { keyword } = do
        redirectToPath "/"
