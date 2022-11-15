# IdealCleanArchitecture

Modular clean architecture implementation. If you're looking to start a new project and familiar with Redux I'd recommend The Composable Architecture (TCA). But if your team prefers/understands Clean Architecture this is a great way to enforce the boundaries between layers.

Package structure:
```
Modules
\ ModuleName
  \ Config
    \ Service (Implementation)
    \ Stylesheet
    \ ViewController (Implementation)
  \ ConfigTests
    \ ServiceTests
    \ ViewControllerSnapshotTests
  \ Core
    \ Entity
    \ Interactor
    \ Presenter
    \ Router
    \ ServiceType (Abstract)
    \ ViewControllerFactoryType (Abstract)
  \ CoreTests
    \ EntityTests
    \ InteractorTests
    \ PresenterTests
    \ RouterTests
```

By including the Presenter, Router, ServiceType, and ViewControllerFactoryType in the Core we can fully unit test the Presentation and Routing logic using spies/mocks of the Services and ViewControllers.

In our ConfigTests we can ensure that our ViewController lays out correctly using a SnapshotTest or our Service is initialized correctly using a ServiceTest.

---

VIPER architecture style
```
View <-> Presenter
Presenter -> Router
Presenter <-> Interactor
Interactor <-> Entity
```
![VIPER](viper.png)

Passing data back typically happens between Views in VIPER, since the Router is unidirectional we don't have to worry about storage of child routers or any memory leaks there.

However, setting the Presenter to our delegate allows us to test more effectively.

```swift
presenterB.delegate = presenterA
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
