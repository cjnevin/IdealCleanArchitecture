import PhantomTypes
import PropertyWrappers
import Foundation

public struct User {
    public var id: ID = .init(UUID())

    @Truncated(maxLength: 25)
    public var name: Name

    @WithinRange(18...100)
    public var age: Age

    public var isAdmin: IsAdmin = false

    public init() {}
}

public enum Types {
    public enum ID {}
    public enum Name {}
    public enum Age {}
    public enum IsAdmin {}
}

public typealias ID = Phantom<Types.ID, UUID>
public typealias Name = Phantom<Types.Name, String>
public typealias Age = Phantom<Types.Age, Int>
public typealias IsAdmin = Phantom<Types.IsAdmin, Bool>
