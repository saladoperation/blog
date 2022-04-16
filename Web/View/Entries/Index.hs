module Web.View.Entries.Index where
import Web.View.Prelude

data IndexView = IndexView { entries :: [Entry] , pagination :: Pagination }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {breadcrumb}

        <h1>Index<a href={pathTo NewEntryAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Entry</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach entries renderEntry}</tbody>
            </table>
            {renderPagination pagination}
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Entries" EntriesAction
                ]

renderEntry :: Entry -> Html
renderEntry entry = [hsx|
    <tr>
        <td>{entry}</td>
        <td><a href={ShowEntryAction (get #id entry)}>Show</a></td>
        <td><a href={EditEntryAction (get #id entry)} class="text-muted">Edit</a></td>
        <td><a href={DeleteEntryAction (get #id entry)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]