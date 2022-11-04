import DependencyContainer
import Foundation

@MainActor
public protocol AlertRouterType: AnyObject {
    func showError(
        title: String,
        message: String
    )
}

public class AlertRouter: AlertRouterType {
    private let navigationController: any NavigationControllerType

    @Dependency(\.alertViewFactory) var alertViewFactory

    public init(navigationController: any NavigationControllerType) {
        self.navigationController = navigationController
    }

    public func showError(
        title: String,
        message: String
    ) {
        let vc = alertViewFactory.make(
            title: title,
            message: message,
            style: .alert,
            actions: AlertAction(
                title: "OK",
                style: .cancel,
                callback: { }
            )
        )
        navigationController.navigate(.present(vc), animated: true)
    }
}
