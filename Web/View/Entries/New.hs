module Web.View.Entries.New where
import Web.View.Prelude

data NewView = NewView { entry :: Entry }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New Entry</h1>
        {renderForm entry}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Entries" EntriesAction
                , breadcrumbText "New Entry"
                ]

renderForm :: Entry -> Html
renderForm entry = formFor entry [hsx|
    {(textField #text)}
    {submitButton}

|]