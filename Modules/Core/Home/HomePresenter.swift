import Foundation

@MainActor
public protocol HomePresenting: AnyObject {
    var view: HomeView? { get set }
}

public protocol HomeView: AnyObject {}

public class HomePresenter: HomePresenting {
    public typealias Routes = Void

    weak public var view: HomeView?

    private let interactor: HomeInteracting
    private let router: Routes

    public init(
        interactor: HomeInteracting,
        router: Routes
    ) {
        self.interactor = interactor
        self.router = router
    }
}
