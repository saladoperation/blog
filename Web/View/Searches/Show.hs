module Web.View.Searches.Show where
import Web.View.Prelude

data ShowView = ShowView { keyword :: Text }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <h1>Search Result for {keyword}</h1>
    |]