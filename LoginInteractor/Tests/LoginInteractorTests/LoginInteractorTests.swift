import XCTest
@testable import LoginInteractor

final class LoginInteractorTests: XCTestCase {
    func testLoginRequest() {
        var request = LoginRequest()
        XCTAssertTrue(request.email.isEmpty)
        request.email = "john.smith@email.com"
        XCTAssertEqual(request.email, "john.smith@email.com")
        request.email = "test.com"
        XCTAssertEqual(request.email, "john.smith@email.com")

        XCTAssertTrue(request.password.isEmpty)
        request.password = "Really Really Really Long Name"
        XCTAssertEqual(request.password, "Really Really Really Long")
    }
}
