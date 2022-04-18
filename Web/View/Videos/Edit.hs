module Web.View.Videos.Edit where
import Web.View.Prelude

data EditView = EditView { video :: Video }

instance View EditView where
    html EditView { .. } = [hsx|
        {breadcrumb}
        <h1>Edit Video</h1>
        {renderForm video}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Videos" VideosAction
                , breadcrumbText "Edit Video"
                ]

renderForm :: Video -> Html
renderForm video = formFor video [hsx|
    {(textField #userId)}
    {(textField #entryId)}
    {(textField #start)}
    {submitButton}

|]