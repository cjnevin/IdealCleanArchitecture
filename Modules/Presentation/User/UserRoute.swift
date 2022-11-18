import Foundation

public protocol UserRoute: AnyObject {
    func startUser(with parentPresenter: UserParentPresenting)
}
