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

VIPER architecture style
```
View <-> Presenter
Presenter -> Coordinator (Router)
Presenter <-> Interactor
Interactor <-> Entity
```
[VIPER](viper.png)
