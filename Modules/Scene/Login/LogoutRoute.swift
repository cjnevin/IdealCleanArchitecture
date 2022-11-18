import Foundation
import Presentation

extension DefaultRouter: LogoutRoute {
    public func logout() {
        isAnimated = true
        close()
    }
}
