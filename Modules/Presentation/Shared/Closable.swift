import Foundation

public protocol Closable: AnyObject {
    func close()
    func close(completion: (() -> Void)?)
}
