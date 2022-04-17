module Web.View.Entries.Edit where
import Web.View.Prelude

data EditView = EditView { entry :: Entry }

instance View EditView where
    html EditView { .. } = [hsx|
        {breadcrumb}
        <h1>Edit Entry</h1>
        {renderForm entry}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Entries" EntriesAction
                , breadcrumbText "Edit Entry"
                ]

renderForm :: Entry -> Html
renderForm entry = formFor entry [hsx|
    {(textField #text)}
    {submitButton}

|]