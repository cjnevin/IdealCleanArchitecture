import Foundation
import UserFeature

extension DefaultRouter: LogoutRoute {
    public func logout() {
        isAnimated = true
        close()
    }
}
