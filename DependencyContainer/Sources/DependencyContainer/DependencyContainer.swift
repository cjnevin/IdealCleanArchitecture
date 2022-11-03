public protocol DependencyKey {
    associatedtype Value
    static var currentValue: Self.Value { get set }
}

public protocol LazyDependencyKey {
    associatedtype Value
    static var currentValue: Self.Value? { get set }
}

extension LazyDependencyKey {
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
    private static var current = DependencyContainer()

    public static subscript<K>(key: K.Type) -> K.Value where K: DependencyKey {
        get { key.currentValue }
        set { key.currentValue = newValue }
    }

    public static subscript<K>(key: K.Type) -> K.Value? where K: LazyDependencyKey {
        get { key.currentValue }
        set { key.currentValue = newValue }
    }

    public static subscript<T>(_ keyPath: WritableKeyPath<DependencyContainer, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }

    public static func set<K>(initialValue: K.Value, key: K.Type) where K: DependencyKey {
        key.currentValue = initialValue
    }

    public static func set<K>(initialValue: K.Value, key: K.Type) where K: LazyDependencyKey {
        key.currentValue = initialValue
    }
}

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
