import Domain
import Foundation

extension DefaultRouter: LogoutRoute {
    public func logout() {
        isAnimated = true
        close()
    }
}
