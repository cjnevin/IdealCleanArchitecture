import Foundation

public protocol ViewControllerType: AnyObject {}

public enum NavigationType {
    case push(ViewControllerType)
    case present(ViewControllerType)
    case pop
    case dismiss
}

public protocol NavigationControllerType: AnyObject {
    func navigate(
        _ type: NavigationType,
        animated: Bool
    )
}
