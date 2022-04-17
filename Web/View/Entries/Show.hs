module Web.View.Entries.Show where
import Web.View.Prelude

data ShowView = ShowView { entry :: Include "videos" Entry }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>{get #text entry}</h1>
        <p>{entry}</p>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Entries" EntriesAction
                            , breadcrumbText "Show Entry"
                            ]