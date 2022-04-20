module Web.View.Searches.Show where
import Web.View.Prelude

data ShowView = ShowView { keyword :: Text, entries :: [Entry] }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <h1>Search Result for {keyword}</h1>
        {forEach entries renderEntry}
    |]
        where
            renderEntry entry = [hsx|
                <div>{ get #text entry }</div>
            |]
