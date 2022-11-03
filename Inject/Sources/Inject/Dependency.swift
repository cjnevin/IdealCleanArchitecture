/// A protocol to define an injected dependency.
public protocol DependencyKey {
    /// Representing the type of the injected dependency.
    associatedtype Value

    /// The current value of the injected dependency.
    static var currentValue: Self.Value { get set }
}

/// A protocol to define an injected dependency whose initial value is set lazy.
public protocol LazyDependencyKey {
    /// Representing the type of the injected dependency.
    associatedtype Value

    /// The current value of the injected dependency.
    static var currentValue: Self.Value? { get set }
}

extension LazyDependencyKey {
    /// The unwrapped value of the injected dependency. Fails if the actual value has not been set before access.
    static var value: Self.Value {
        get {
            guard let currentValue = currentValue else {
                preconditionFailure("A value must be set before accessing the property.")
            }
            return currentValue
        }
        set {
            currentValue = newValue
        }
    }
}

public class DependencyContainer {
    /// Singleton instance used to be accessed by the computed properties.
    private static var current = DependencyContainer()

    /// Access the dependency with the specified `key`.
    /// - Parameter key: Implementation type of `DependencyKey`.
    public static subscript<K>(key: K.Type) -> K.Value where K: DependencyKey {
        get { key.currentValue }
        set { key.currentValue = newValue }
    }

    /// Accesses the dependency with the specified `keyPath`.
    /// - Parameter keyPath: The key path of the computed property.
    public static subscript<T>(_ keyPath: WritableKeyPath<DependencyContainer, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }

    /// Set the initial value for the specified `key`. This method has to be called before the property is injected or accessed anywhere.
    /// - Parameter initialValue: The initial value that is injected wherever it is used.
    /// - Parameter key: The key to set the value for.
    public static func set<K>(initialValue: K.Value, key: K.Type) where K: LazyDependencyKey {
        key.currentValue = initialValue
    }
}

/// A property wrapper type that reflects a dependency injected using `DependencyContainer`.
@propertyWrapper
public struct Dependency<T> {
    private let keyPath: WritableKeyPath<DependencyContainer, T>

    public var wrappedValue: T {
        get { DependencyContainer[keyPath] }
        set { DependencyContainer[keyPath] = newValue }
    }

    public init(_ keyPath: WritableKeyPath<DependencyContainer, T>) {
        self.keyPath = keyPath
    }
}

public class MainResolver {
    public static let shared = MainResolver()

    private var dependencies: [Any] = []

    public func register<T>(_ dependency: T) {
        dependencies.append(dependency)
    }

    public func resolve<T>(_ dependencyType: T.Type) -> T {
        dependencies.first(where: { $0 is T }) as! T
    }
}

import SwiftUI
@propertyWrapper
public struct Inject<Value> {
    public private(set) var wrappedValue: Value

    public init(_ resolver: MainResolver = .shared) {
        wrappedValue = resolver.resolve(Value.self)
    }
}
