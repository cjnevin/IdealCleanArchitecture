import XCTest
import Assert
@testable import LoginCore

final class LoginServiceTests: XCTestCase {
    func testLoginRequest() {
        var request = LoginRequest()
        assert(request.email.isEmpty) == true
        assert(request.isValid) == false

        request.email = "john.smith@email.com"
        assert(request.email) == "john.smith@email.com"

        request.email = "test.com"
        assert(request.email) == "john.smith@email.com"

        assert(request.isValid) == false

        assert(request.password.isEmpty) == true
        request.password = "Really Really Really Long Name"
        assert(request.password) == "Really Really Really Long"

        assert(request.isValid) == true
    }
}
