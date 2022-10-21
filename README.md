# IdealCleanArchitecture

Package structure:
```
AppDelegate
-> LoginCoordinator
  -> LoginViewController
    -> LoginPresenter
      -> LoginInteractor
        -> LoginEntity
        -> UserEntity
      -> UserCoordinator
        -> UserViewController
          -> UserPresenter
            -> UserInteractor
              -> UserEntity
Dependencies
  -> LoginEntity
  -> LoginInteractor
  -> UserEntity
```
