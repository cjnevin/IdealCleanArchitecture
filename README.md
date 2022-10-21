# IdealCleanArchitecture

Modular clean architecture implementation. If you're looking to start a new project and familiar with Redux I'd recommend The Composable Architecture (TCA). But if your team prefers/understands Clean Architecture this is a great way to enforce the boundaries between layers.

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
![VIPER](viper.png)

Passing data back typically happens between Views in VIPER, since the Coordinator is unidirectional we don't have to worry about storage of child coordinators or any memory leaks there.

```swift
viewB.delegate = viewA
```
