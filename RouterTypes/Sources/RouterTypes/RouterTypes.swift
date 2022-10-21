@MainActor
public protocol AlertRouterType: AnyObject {
    func showError(
        title: String,
        message: String
    )
}

@MainActor
public protocol LoginRouterType: AnyObject {
    func start()
}

@MainActor
public protocol UserRouterType: AnyObject {
    func start()
    func finish()
}
