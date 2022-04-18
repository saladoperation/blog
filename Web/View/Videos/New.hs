module Web.View.Videos.New where
import Web.View.Prelude

data NewView = NewView { video :: Video }

instance View NewView where
    html NewView { .. } = [hsx|
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
    <div class="form-group">
        <input name="url" type="url" class="form-control" placeholder="https://youtu.be/dQw4w9WgXcQ?t=43"/>
    </div>
    {submitButton}

|]