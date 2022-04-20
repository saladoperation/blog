module Web.Controller.Searches where

import Web.Controller.Prelude
import Web.View.Searches.Show

instance Controller SearchesController where
    action ShowSearchAction { keyword } = do
        render ShowView { .. }

