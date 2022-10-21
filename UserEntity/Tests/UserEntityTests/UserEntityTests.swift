import XCTest
@testable import UserEntity

final class UserEntityTests: XCTestCase {
    func testUser() {
        var user = User()
        XCTAssertTrue(user.name.isEmpty)
        user.name = "John Smith"
        XCTAssertEqual(user.name, "John Smith")
        user.name = "Really Really Really Long Name"
        XCTAssertEqual(user.name, "Really Really Really Long")

        XCTAssertEqual(user.isAdmin, false)
        user.isAdmin = true
        XCTAssertEqual(user.isAdmin, true)

        XCTAssertEqual(user.age, 18)
        user.age = 150
        XCTAssertEqual(user.age, 100)
    }
}
