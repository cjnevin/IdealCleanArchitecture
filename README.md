# IdealCleanArchitecture

Modular clean architecture implementation. If you're looking to start a new project and familiar with Redux I'd recommend The Composable Architecture (TCA). But if your team prefers/understands Clean Architecture this is a great way to enforce the boundaries between layers.

Package structure:
```
Modules
\ ModuleName
  \ Config
    \ Router
    \ Service
    \ Stylesheet
    \ ViewController
  \ ConfigTests
    \ ServiceIntegrationTests (optional)
    \ UITests (tests routing, services, and user interaction)
    \ ViewControllerSnapshotTests (with PresenterStub)
  \ Core
    \ Entity
    \ Interactor
    \ Presenter
    \ Routes (Abstract)
    \ ServiceType (Abstract)
  \ CoreTests
    \ EntityTests
    \ InteractorTests (with ServiceSpy)
    \ PresenterTests (with RouterSpy)
```

**Core:** We can achieve 100% unit test coverage of our entities, interactors, presenters, and routing by providing a ServiceSpy and a RouterSpy.

**Config:** We can snapshot test our ViewControllers by mocking the view values and stubbing the Presenter. We may also want to write integration tests for our Services to ensure our wrapper is doing what is intended. We can also write UITests to ensure that everything works together as expected, we may want to Mock our Services to ensure we aren't modifying real environments.

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

Access is enforced using Swift Package Manager to ensure proper boundaries between Core and Config. Features each have their own Core and Config. Shared code also has it's own Core and Config which can be imported by Features.

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
