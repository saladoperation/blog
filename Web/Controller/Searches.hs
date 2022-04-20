module Web.Controller.Searches where

instance Controller SearchesController where
    action ShowSearchAction { keyword } = do
        render ShowView { .. }
