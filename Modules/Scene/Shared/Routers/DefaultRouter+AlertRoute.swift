import Domain
import UIKit

extension DefaultRouter: AlertRoute {
    public func showError(title: String, message: String) {
        let viewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        viewController.addAction(.init(title: "OK", style: .cancel))
        route(to: viewController, as: ModalTransition())
    }
}
