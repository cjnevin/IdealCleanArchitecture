import CommonConfig
import UserCore

extension DefaultRouter: UserRoute {
    public func startUser(from parentPresenter: UserParentPresenter) {
        let transition = PushTransition(isAnimated: true)
        let router = DefaultRouter(rootTransition: transition)
        let presenter = UserPresenter(interactor: UserInteractor(), router: router)
        let viewController = UserViewController(presenter: presenter)
        presenter.delegate = viewController
        presenter.parentPresenter = parentPresenter
        router.root = viewController
        route(to: viewController, as: transition)
    }
}
