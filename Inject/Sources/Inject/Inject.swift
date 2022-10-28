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
