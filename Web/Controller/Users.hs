module Web.Controller.Users where

import Web.Controller.Prelude
import Web.View.Users.New
import IHP.ValidationSupport.ValidateIsUnique

instance Controller UsersController where
    action NewUserAction = do
        let user = newRecord
        render NewView { .. }

    action CreateUserAction = do
        let user = newRecord @User
        user
            |> fill @["email", "passwordHash"]
            |> validateField #email isEmail
            |> validateField #passwordHash nonEmpty
            |> validateIsUniqueCaseInsensitive #email
            >>= ifValid \case
                Left user -> render NewView { .. }
                Right user -> do
                    hashed <- hashPassword (get #passwordHash user)
                    user <- user
                        |> set #passwordHash hashed
                        |> createRecord
                    setSuccessMessage "You have registered successfully"
                    redirectToPath "/"

buildUser user = user
    |> fill @["email","passwordHash","failedLoginAttempts"]
