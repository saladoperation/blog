module Web.Controller.Videos where

import Web.Controller.Prelude
import Web.View.Videos.Index
import Web.View.Videos.New
import Web.View.Videos.Edit
import Web.View.Videos.Show
import Network.URI (parseURI, uriPath)
import Data.Text as T

instance Controller VideosController where
    action VideosAction = do
        videos <- query @Video |> fetch
        render IndexView { .. }

    action NewVideoAction = do
        let video = newRecord
        render NewView { .. }

    action ShowVideoAction { videoId } = do
        video <- fetch videoId
        render ShowView { .. }

    action EditVideoAction { videoId } = do
        video <- fetch videoId
        render EditView { .. }

    action UpdateVideoAction { videoId } = do
        video <- fetch videoId
        video
            |> buildVideo
            |> ifValid \case
                Left video -> render EditView { .. }
                Right video -> do
                    video <- video |> updateRecord
                    setSuccessMessage "Video updated"
                    redirectTo EditVideoAction { .. }

    action CreateVideoAction = do
        let text = param @Text "text"
        maybeEntry <- query @Entry |> findMaybeBy #text text
        case maybeEntry of
            Nothing -> do
                let entry = newRecord @Entry
                entry
                    |> buildEntry
                    |> ifValid \case
                        Left entry -> redirectToPath "/"
                        Right entry -> createVideo entry True
            Just entry -> createVideo entry False

    action DeleteVideoAction { videoId } = do
        video <- fetch videoId
        deleteRecord video
        setSuccessMessage "Video deleted"
        redirectTo VideosAction

buildVideo video = video
    |> fill @["entryId","start"]

buildEntry entry = entry
    |> fill @'["text"]

createVideo entry new = do
    ensureIsUser
    let url = param @Text "url"
    case parseURI $ T.unpack url of
        Nothing -> redirectToPath "/"
        Just uri -> do
            let videoId = T.pack $ uriPath uri
            let video = newRecord @Video
            video
                |> buildVideo
                |> set #userId currentUserId
                |> set #entryId (get #id entry)
                |> set #videoId videoId
                |> ifValid \case
                    Left video -> render NewView { .. } 
                    Right video -> do 
                        entry <- if new
                            then entry |> createRecord
                            else pure entry
                        video <- video 
                            |> set #entryId (get #id entry)
                            |> createRecord 
                        setSuccessMessage "Video created"
                        redirectTo VideosAction