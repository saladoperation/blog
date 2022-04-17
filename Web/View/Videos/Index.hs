module Web.View.Videos.Index where
import Web.View.Prelude

data IndexView = IndexView { videos :: [Video]  }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {breadcrumb}

        <h1>Index<a href={pathTo NewVideoAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Video</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach videos renderVideo}</tbody>
            </table>
            
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Videos" VideosAction
                ]

renderVideo :: Video -> Html
renderVideo video = [hsx|
    <tr>
        <td>{video}</td>
        <td><a href={ShowVideoAction (get #id video)}>Show</a></td>
        <td><a href={EditVideoAction (get #id video)} class="text-muted">Edit</a></td>
        <td><a href={DeleteVideoAction (get #id video)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]