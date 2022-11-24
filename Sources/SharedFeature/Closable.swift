import Foundation

@MainActor
public protocol Closable: AnyObject {
    func close()
    func close(completion: (() -> Void)?)
}
