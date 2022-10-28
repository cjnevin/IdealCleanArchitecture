# IdealCleanArchitecture

Modular clean architecture implementation. If you're looking to start a new project and familiar with Redux I'd recommend The Composable Architecture (TCA). But if your team prefers/understands Clean Architecture this is a great way to enforce the boundaries between layers.

Package structure:
```
AppDelegate
-> Dependencies
  -> LoginEntity
  -> LoginInteractor
  -> UserEntity
-> LoginRouter
  -> LoginViewController
    -> LoginPresenter
      -> LoginInteractor
        -> LoginEntity
        -> UserEntity
      -> UserRouter
        -> UserViewController
          -> UserPresenter
            -> UserInteractor
              -> UserEntity
```

VIPER architecture style
```
View <-> Presenter
Presenter -> Router
Presenter <-> Interactor
Interactor <-> Entity
```
![VIPER](viper.png)

Passing data back typically happens between Views in VIPER, since the Router is unidirectional we don't have to worry about storage of child routers or any memory leaks there.

```swift
viewB.delegate = viewA
```

This can be seen in the `UserViewController` it imports `LoginViewController` package which provides the `LogoutDelegate` which is adhered to by the `LoginViewController`.
