module Web.Controller.Videos where

import Web.Controller.Prelude
import Web.View.Videos.Index
import Web.View.Videos.New
import Web.View.Videos.Edit
import Web.View.Videos.Show
import qualified Network.URI as URI
import qualified Data.Text as T
import qualified Data.Text.Read as Read

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
        ensureIsUser
        let text = param @Text "text"
        let url = param @Text "url"
        let video = newRecord @Video
        case URI.parseURI $ T.unpack url of
            Nothing -> render NewView { .. } 
            Just uri -> do
                let videoId = T.tail $ T.pack $ URI.uriPath uri
                case Read.decimal $ T.drop 3 $ T.pack $ URI.uriQuery uri of
                    Left _ -> render NewView { .. } 
                    Right (start, _) -> do
                        video
                            |> buildVideo
                            |> set #userId currentUserId
                            |> set #entryId (get #id $ newRecord @Entry)
                            |> set #videoId videoId
                            |> set #start start
                            |> ifValid \case
                                Left video -> render NewView { .. } 
                                Right video -> do
                                    maybeEntry <- query @Entry |> findMaybeBy #text text
                                    case maybeEntry of
                                        Nothing -> do
                                            let entry = newRecord @Entry
                                            entry
                                                |> buildEntry
                                                |> ifValid \case
                                                    Left entry -> render NewView { .. } 
                                                    Right entry -> do
                                                        entry <- entry |> createRecord
                                                        createVideo entry video
                                        Just entry -> createVideo entry video

    action DeleteVideoAction { videoId } = do
        video <- fetch videoId
        deleteRecord video
        setSuccessMessage "Video deleted"
        redirectTo VideosAction

buildVideo video = video
    |> fill @["entryId","start"]

buildEntry entry = entry
    |> fill @'["text"]

createVideo entry video = do
    video 
        |> set #entryId (get #id entry)
        |> createRecord 
    setSuccessMessage "Video created"
    redirectTo VideosAction