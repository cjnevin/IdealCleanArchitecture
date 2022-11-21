# IdealCleanArchitecture

Modular clean architecture implementation. If you're looking to start a new project and familiar with Redux I'd recommend The Composable Architecture (TCA). But if your team prefers/understands Clean Architecture this is a great way to enforce the boundaries between layers.

Each feature is broken out into it's own modules, one for *Infrastructure* (if needed), one for *Presentation*, one for *UI*.

*Domain* is where feature modules overlap (i.e. Login Feature will know about User Feature), so it makes sense having this as a shared module which stores all of the abstract types (services, routes, etc), entities, and interactors.

*App* is also a common area where all of the wiring is done between modules, this is where the *Routers* are implemented and *Dependencies* are injected.

Legend:
```
💭 - Abstract (Protocol)
🏛️ - Concrete Implementation
🧰 - Module
🛠️ - Test
🎭 - Test Mock/Spy
```

Module structure:
```
🧰Domain (Abstract Types, Interactors, Entities)
\ 🏛️Entity
\ 💭Interacting
\ 💭InteractorDelegate
\ 🏛️Interactor: 💭Interacting
\ 💭Route
\ 💭Service
\ 🛠️Tests: XCTest
  \ 🏛️InteractorTest: XCTestCase
    \ 🎭InteractorDelegateSpy: 💭InteractorDelegate
    \ 🎭ServiceMock: 💭Service

Infrastructure (Implementation of Services)
\ 🧰ServiceModule
  \ 🏛️Service: 💭Service
    \ 🛠️Tests: XCTest
      \ 🏛️ServiceTest: XCTestCase

Presentation (Responsible for Calling Interactor/Router and Updating View)
\ 🧰FeatureModule
  \ 💭Interacting
  \ 💭Presenting
  \ 🏛️Presenter: 💭InteractorDelegate
  \ 💭View
  \ 🛠️Tests: XCTest
    \ 🏛️PresenterTest: XCTestCase
      \ 🎭InteractorMock: 💭Interacting
      \ 🎭RouteSpy: 💭Route
      \ 🎭ViewSpy: 💭View

UI (Responsible for Layout, Mapping ViewModel to UIView)
\ 🧰FeatureModule
  \ 🏛️Stylesheet
  \ 🏛️View: 💭View
  \ 🛠️Tests: XCTest
    \ 🏛️ViewTest: XCTestCase
      \ 🎭PresenterMock: 💭Presenting

App (Responsible for Wiring Up Routes and Services)
\ Injects 🏛️Service(s)
\ Starts Initial 🏛️Router
\ 🏛️Router: 💭Route
\ 🛠️Tests: XCUITest
  \ 🏛️UITest: XCUITestCase
    \ 🎭ServiceMock: 💭Service
```

Feature Example:
```
🧰Domain
\ 🏛️Settings
\ 💭SettingsInteractor
\ 💭SettingsPresenting
\ 💭SettingsRoute
\ 💭SettingsService

Infrastructure:
\ 🧰SettingsInfrastructure
  \ 🏛️SettingsModel (Mapping from/to 🏛️Settings)
  \ 🏛️SettingsService: 💭SettingsService

Presentation:
\ 🧰SettingsPresentation
  \ 🏛️SettingsPresenter: 💭SettingsPresenting
  \ 💭SettingsView

UI:
\ 🧰SettingsUI
  \ 🏛️SettingsViewController: 💭SettingsView

App:
\ 🏛️DefaultRouter: 💭SettingsRoute
```

---

VIPER architecture style
```
View <-> Presenter
Presenter -> Router
Presenter <-> Interactor
Interactor <-> Entity
```
![VIPER](viper.png)

Passing data back typically happens between Views in VIPER, however, setting the Presenter to our delegate allows us to test more effectively.

```swift
presenterB.parentPresenter = presenterA
```

---

## Concepts Employed

I have employed several concepts to make this code more readable/usable.

If you'd like to read more about the approach there is [more information available here](https://medium.com/@cjnevin/modular-viper-architecture-9a7cdb7475f8).

### Swift Package Manager

Access is enforced using Swift Package Manager to ensure proper boundaries between Core and UI.

### `@Dependency` Injection

Dependencies are injected in a similar fashion to `@EnvironmentObject` using `@Dependency`, however, `@Dependency` supports protocols, so it's easier to mock.

### `@dynamicMemberLookup` and `Phantom` Types

Models enforce type restrictions by leveraging `@dynamicMemberLookup` on top of `Phantom Types`. [More information available here](https://levelup.gitconnected.com/expressible-dynamic-phantom-types-513091b63f04).

### `@propertyWrapper` Styling

Styles are created using `@propertyWrapper`'s. [More information available here](https://medium.com/@cjnevin/view-styling-with-propertywrapper-92d8476e96a7).

### `@resultBuilder` `@AutoLayoutBuilder`

Constraints are created in a more Swifty way with support for nesting. [More information available here](https://betterprogramming.pub/autolayoutbuilder-294badac5015).

### `Assert` Testing

Tests are written with a little DSL I wrote over `XCTAssert`. [More information available here](https://betterprogramming.pub/assert-my-wrapper-framework-around-xctest-7d6bea2d05f9).

### Routers

I am using a slightly modified approach detailed by Cassius Pacheco which allows for composable routing. [He wrote a great article here.](https://cassiuspacheco.com/clean-simple-and-composable-routing-for-ios-apps)
