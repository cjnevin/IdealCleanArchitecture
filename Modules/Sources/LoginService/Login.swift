import Foundation
import PhantomTypes

public enum Types {
    public enum Email {}
    public enum Password {}
}

public typealias Email = Phantom<Types.Email, String>
public typealias Password = Phantom<Types.Password, String>
