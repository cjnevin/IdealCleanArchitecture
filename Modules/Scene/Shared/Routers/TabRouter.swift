import UIKit

@MainActor
public class TabRouter: DefaultRouter {
    var homeRouter: DefaultRouter?
    var settingsRouter: DefaultRouter?
    
    public init(window: UIWindow?) {
        super.init(rootTransition: EmptyTransition())
        window?.rootViewController = UITabBarController()
        root = window?.rootViewController
        startHome()
        startSettings()
    }
}
