module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types
import IHP.LoginSupport.Types

data WebApplication = WebApplication deriving (Eq, Show)


data StaticController = WelcomeAction deriving (Eq, Show, Data)

instance HasNewSessionUrl User where
    newSessionUrl _ = "/NewSession"

type instance CurrentUserRecord = User

data SessionsController
    = NewSessionAction
    | CreateSessionAction
    | DeleteSessionAction
    deriving (Eq, Show, Data)

data UsersController
    = NewUserAction
    | CreateUserAction
    deriving (Eq, Show, Data)

data EntriesController
    = EntriesAction
    | NewEntryAction
    | ShowEntryAction { entryId :: !(Id Entry) }
    | CreateEntryAction
    | EditEntryAction { entryId :: !(Id Entry) }
    | UpdateEntryAction { entryId :: !(Id Entry) }
    | DeleteEntryAction { entryId :: !(Id Entry) }
    deriving (Eq, Show, Data)

data ExamplesController
    = ExamplesAction
    | NewExampleAction
    | ShowExampleAction { exampleId :: !(Id Example) }
    | CreateExampleAction
    | EditExampleAction { exampleId :: !(Id Example) }
    | UpdateExampleAction { exampleId :: !(Id Example) }
    | DeleteExampleAction { exampleId :: !(Id Example) }
    deriving (Eq, Show, Data)
