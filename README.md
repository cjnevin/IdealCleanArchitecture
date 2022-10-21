# IdealCleanArchitecture

Package structure:
```
AppDelegate
-> Dependencies
  -> LoginEntity
  -> LoginInteractor
  -> UserEntity
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
```
