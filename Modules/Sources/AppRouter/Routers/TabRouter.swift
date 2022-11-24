import UIKit

@MainActor
public class TabRouter: DefaultRouter {
    open var homeRouter: DefaultRouter?
    open var settingsRouter: DefaultRouter?
    
    public init(window: UIWindow?) {
        super.init(rootTransition: EmptyTransition())
        window?.rootViewController = UITabBarController()
        root = window?.rootViewController
    }
}
