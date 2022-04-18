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
            |> ifValid \case
                Left video -> render EditView { .. }
                Right video -> do
                    video <- video |> updateRecord
                    setSuccessMessage "Video updated"
                    redirectTo EditVideoAction { .. }

    action CreateVideoAction = do
        ensureIsUser
        let video = newRecord @Video
        case param @Text "url"
                |> T.unpack
                |> URI.parseURI of
            Nothing -> render NewView { .. } 
            Just uri -> do
                let videoId = URI.uriPath uri
                                |> T.pack
                                |> T.tail
                case URI.uriQuery uri
                        |> T.pack
                        |> T.drop 3
                        |> Read.decimal of
                    Left _ -> render NewView { .. } 
                    Right (start, _) -> video
                        |> set #userId currentUserId
                        |> set #entryId (get #id $ newRecord @Entry)
                        |> set #videoId videoId
                        |> set #start start
                        |> ifValid \case
                            Left video -> render NewView { .. } 
                            Right video -> do
                                maybeEntry <- query @Entry |> findMaybeBy #text (param @Text "text")
                                case maybeEntry of
                                    Nothing -> newRecord @Entry
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

buildEntry entry = entry
    |> fill @'["text"]

createVideo entry video = do
    video 
        |> set #entryId (get #id entry)
        |> createRecord 
    setSuccessMessage "Video created"
    redirectTo VideosAction