import Foundation

@MainActor
public protocol UserRoute: AnyObject {
    func startUser(with parentPresenter: UserParentPresenting)
}
