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

Clean Swift architecture style
```
View <-> Presenter
Presenter <-> Interactor
Presenter -> Coordinator
```
