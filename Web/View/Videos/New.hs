module Web.View.Videos.New where
import Web.View.Prelude

data NewView = NewView { video :: Video }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New Video</h1>
        {renderForm video}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Videos" VideosAction
                , breadcrumbText "New Video"
                ]

renderForm :: Video -> Html
renderForm video = formFor video [hsx|
    <div class="form-group">
        <input name="text" type="text" class="form-control" placeholder="Text"/>
    </div>
    {(textField #start)}
    {submitButton}

|]