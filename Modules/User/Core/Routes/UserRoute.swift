import Foundation

@MainActor
public protocol UserRoute: AnyObject {
    func startUser(from parent: UserParentPresenter)
}
