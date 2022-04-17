module Web.Controller.Examples where

import Web.Controller.Prelude
import Web.View.Examples.Index
import Web.View.Examples.New
import Web.View.Examples.Edit
import Web.View.Examples.Show

instance Controller ExamplesController where
    action ExamplesAction = do
        examples <- query @Example |> fetch
        render IndexView { .. }

    action NewExampleAction = do
        let example = newRecord
        render NewView { .. }

    action ShowExampleAction { exampleId } = do
        example <- fetch exampleId
        render ShowView { .. }

    action EditExampleAction { exampleId } = do
        example <- fetch exampleId
        render EditView { .. }

    action UpdateExampleAction { exampleId } = do
        example <- fetch exampleId
        example
            |> buildExample
            |> ifValid \case
                Left example -> render EditView { .. }
                Right example -> do
                    example <- example |> updateRecord
                    setSuccessMessage "Example updated"
                    redirectTo EditExampleAction { .. }

    action CreateExampleAction = do
        let text = param @Text "text"
        maybeEntry <- query @Entry |> findMaybeBy #text text
        case maybeEntry of
            Nothing -> redirectToPath "/"
            Just entry -> do
                ensureIsUser
                let example = newRecord @Example
                example
                    |> buildExample
                    |> set #userId currentUserId
                    |> set #entryId (get #id entry)
                    |> ifValid \case
                        Left example -> render NewView { .. } 
                        Right example -> do
                            example <- example |> createRecord
                            setSuccessMessage "Example created"
                            redirectTo ExamplesAction

    action DeleteExampleAction { exampleId } = do
        example <- fetch exampleId
        deleteRecord example
        setSuccessMessage "Example deleted"
        redirectTo ExamplesAction

buildExample example = example
    |> fill @["entryId","startTime"]
