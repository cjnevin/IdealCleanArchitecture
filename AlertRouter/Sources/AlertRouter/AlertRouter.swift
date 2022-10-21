import RouterTypes
import ViewControllerTypes
import UIKit

public class AlertRouter: AlertRouterType {
    private let navigationController: NavigationController

    public init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }

    public func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        navigationController.navigate(.present(alert), animated: true)
    }
}
