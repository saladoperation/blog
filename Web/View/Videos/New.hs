module Web.View.Videos.New where
import Web.View.Prelude

data NewView = NewView { video :: Video, entry :: Entry }

instance View NewView where
    html NewView { .. } = [hsx|
        <h1>New Video</h1>
        <form id="main-form" method="POST" action={CreateVideoAction}>
            {renderForm video entry}
            <input type="submit" class="btn btn-primary"/>
        </form>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Videos" VideosAction
                , breadcrumbText "New Video"
                ]

renderForm :: Video -> Entry -> Html
renderForm video entry = [hsx|
    <div class="form-group">
        <input name="text" type="text" class={classes ["form-control", ("is-invalid", isInvalidText)]} placeholder="Text"/>
        {textFeedback}
    </div>
    <div class="form-group">
        <input name="url" type="url" class="form-control" placeholder="https://youtu.be/dQw4w9WgXcQ?t=43"/>
    </div>
|]
    where
        isInvalidText = isJust (getValidationFailure #text entry)
        textFeedback = case getValidationFailure #text entry of
            Just result -> [hsx|<div class="invalid-feedback is-invalid">{result}</div>|]
            Nothing -> [hsx|<div class="invalid-feedback">there is no error</div>|]


