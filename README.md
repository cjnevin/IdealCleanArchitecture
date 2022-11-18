# IdealCleanArchitecture

Modular clean architecture implementation. If you're looking to start a new project and familiar with Redux I'd recommend The Composable Architecture (TCA). But if your team prefers/understands Clean Architecture this is a great way to enforce the boundaries between layers.

Package structure:
```
Modules
\ App
  \ Injects 🏛️Service(s) into DependencyContainer
  \ Starts initial Scene by calling 🏛️Router
\ 🧰AppTests (XCUITest)
  \ Ensure 🏛️MockService(s) update views as expected
  \ Ensure 🏛️Router(s) navigates as expected
\ Domain
  \ Feature
    \ 🏛️Entity (primitive types only)
    \ 🏛️Interactor (implements 💭Interacting)
      \ Calls 💭Service with 🏛️Entity (Request)
      \ Returns 🏛️Entity (Response) to 💭InteractorDelegate
\ DomainTests
  \ Feature
    \ 🧰EntityTests (XCTest)
    \ 🧰InteractorTests (XCTest)
      \ Confirms 💭InteractorDelegate (i.e. 🏛️TestInteractorDelegate) is called
      \ Ensure 💭Service (i.e. 🏛️MockService) results are returned properly
\ Infrastructure
  \ 🏛️Service (implements 💭Service)
\ InfrastructureTests (XCTest)
  \ 🧰ServiceIntegrationTests (optional)
\ Presentation
  \ Feature
    \ 🏛️Presenter (implements 💭Presenting)
      \ Calls 💭Route(s)
      \ Calls 💭Interacting with 🏛️Entity
      \ Calls 💭View with 🏛️ViewModel updates
      \ Maps 🏛️Entity to 🏛️ViewModel
    \ 🏛️ViewModel (primitive types only, no UIKit)
\ PresentationTests 
  \ Feature
    \ 🧰PresenterTests (XCTest)
      \ Confirms 💭Route(s) (i.e. 🏛️TestRouter) are called
      \ Ensure 💭Interacting (i.e. 🏛️MockInteractor) results are mapped properly
\ Scene
  \ Feature
    \ 🏛️Router (implements 💭Route)
    \ 🏛️Stylesheet (i.e. UIKit)
    \ 🏛️ViewController (implements 💭View)
      \ Maps 🏛️ViewModel to 🏛️Stylesheet
\ SceneTests
  \ Feature
    \ 🧰ViewControllerTests
      \ Ensure 💭Presenting (i.e. 🏛️MockPresenter) results are rendered properly

--

Legend:
💭 - Abstract (Protocol)
🏛️ - Concrete Implementation
🧰 - Test

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
