module Web.View.Entries.Show where
import Web.View.Prelude

data ShowView = ShowView { entry :: Entry }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>Show Entry</h1>
        <p>{entry}</p>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Entries" EntriesAction
                            , breadcrumbText "Show Entry"
                            ]