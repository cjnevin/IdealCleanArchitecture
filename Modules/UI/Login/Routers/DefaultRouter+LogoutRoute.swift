import Core

extension DefaultRouter: LogoutRoute {
    public func logout() {
        isAnimated = true
        close()
    }
}
