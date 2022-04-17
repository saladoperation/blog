module Web.Controller.Entries where

import Web.Controller.Prelude
import Web.View.Entries.Index
import Web.View.Entries.New
import Web.View.Entries.Edit
import Web.View.Entries.Show

instance Controller EntriesController where
    action EntriesAction = do
        (entriesQ, pagination) <- query @Entry |> paginate
        entries <- entriesQ |> fetch
        render IndexView { .. }

    action NewEntryAction = do
        let entry = newRecord
        render NewView { .. }

    action ShowEntryAction { entryId } = do
        entry <- fetch entryId >>= fetchRelated #videos
        render ShowView { .. }

    action EditEntryAction { entryId } = do
        entry <- fetch entryId
        render EditView { .. }

    action UpdateEntryAction { entryId } = do
        entry <- fetch entryId
        entry
            |> buildEntry
            |> ifValid \case
                Left entry -> render EditView { .. }
                Right entry -> do
                    entry <- entry |> updateRecord
                    setSuccessMessage "Entry updated"
                    redirectTo EditEntryAction { .. }

    action CreateEntryAction = do
        let entry = newRecord @Entry
        entry
            |> buildEntry
            |> ifValid \case
                Left entry -> render NewView { .. } 
                Right entry -> do
                    entry <- entry |> createRecord
                    setSuccessMessage "Entry created"
                    redirectTo EntriesAction

    action DeleteEntryAction { entryId } = do
        entry <- fetch entryId
        deleteRecord entry
        setSuccessMessage "Entry deleted"
        redirectTo EntriesAction

buildEntry entry = entry
    |> fill @'["text"]
