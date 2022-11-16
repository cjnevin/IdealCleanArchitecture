import PhantomTypes
import PropertyWrappers
import Foundation

public struct User {
    public var id: ID = .init(UUID())

    @Truncated(maxLength: 25)
    public var name: Name

    @WithinRange(18...100)
    public var age: Age

    @Truncated(maxLength: 200)
    public var blurb: Blurb

    public var contactByEmail: ContactByEmail = true

    public var contactBySMS: ContactBySMS = false

    public var isAdmin: IsAdmin = false

    public init() {}
}

public extension Types {
    enum ID {}
    enum Name {}
    enum Age {}
    enum Blurb {}
    enum ContactByEmail {}
    enum ContactBySMS {}
    enum IsAdmin {}
}

public typealias ID = Phantom<Types.ID, UUID>
public typealias Name = Phantom<Types.Name, String>
public typealias Age = Phantom<Types.Age, Int>
public typealias Blurb = Phantom<Types.Blurb, String>
public typealias IsAdmin = Phantom<Types.IsAdmin, Bool>
public typealias ContactByEmail = Phantom<Types.ContactByEmail, Bool>
public typealias ContactBySMS = Phantom<Types.ContactBySMS, Bool>
