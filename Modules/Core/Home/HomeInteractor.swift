import DependencyContainer

public protocol HomeInteractorDelegate: AnyObject {}

public protocol HomeInteracting: AnyObject {
    var delegate: HomeInteractorDelegate? { get set }
}

public class HomeInteractor: HomeInteracting {
    public weak var delegate: HomeInteractorDelegate?
    public init() {}
}
