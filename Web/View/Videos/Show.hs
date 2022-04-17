module Web.View.Videos.Show where
import Web.View.Prelude

data ShowView = ShowView { video :: Video }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>Show Video</h1>
        <p>{video}</p>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Videos" VideosAction
                            , breadcrumbText "Show Video"
                            ]