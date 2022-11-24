import XCTest
import Assert
@testable import UserService

final class UserTests: XCTestCase {
    func testUser() {
        var user = User()
        assert(user.name.isEmpty) == true
        user.name = "John Smith"
        assert(user.name) == "John Smith"
        user.name = "Really Really Really Long Name"
        assert(user.name) == "Really Really Really Long"

        assert(user.isAdmin) == false
        user.isAdmin = true
        assert(user.isAdmin) == true

        assert(user.age) == 18
        user.age = 150
        assert(user.age) == 100
    }
}
