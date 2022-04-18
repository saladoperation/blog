module Web.View.Entries.Show where
import Web.View.Prelude

data ShowView = ShowView { entry :: Include "videos" Entry }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>{get #text entry}</h1>
        {forEach (entry |> get #videos) renderVideo}
        <p>{entry}</p>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Entries" EntriesAction
                            , breadcrumbText "Show Entry"
                            ]

renderVideo video = [hsx|

    <div><iframe allowfullscreen="" frameborder="0" height="315" src={"http://www.youtube.com/embed/" <> (get #videoId video) <> "?start=" <> (show $ get #start video)} width="420"></iframe></div>

|]