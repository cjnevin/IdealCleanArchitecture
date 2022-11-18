import XCTest
import DependencyContainer
import Assert
@testable import Domain

final class LoginInteractorTests: XCTestCase {
    var sut: LoginInteractor!
    var loginService = LoginServiceMock()
    var userService = UserServiceSpy()
    let delegate = LoginInteractorDelegateSpy()

    override func setUp() {
        super.setUp()
        DependencyContainer
            .set(loginService, for: LoginServiceDependencyKey.self)
            .set(userService, for: UserServiceDependencyKey.self)
        sut = LoginInteractor()
        sut.delegate = delegate
    }

    func testPrepare() throws {
        sut.prepare()
        try assert(unwrapping: delegate.state).emailIsValid == false
        try assert(unwrapping: delegate.state).passwordIsValid == false
        try assert(unwrapping: delegate.state).formIsValid == false
    }

    func testValidForm() throws {
        sut.setEmail("test.com")
        try assert(unwrapping: delegate.state).emailIsValid == false
        try assert(unwrapping: delegate.state).formIsValid == false

        sut.setEmail("john.smith@email.com")
        try assert(unwrapping: delegate.state).emailIsValid == true
        
        sut.setPassword("")
        try assert(unwrapping: delegate.state).passwordIsValid == false
        try assert(unwrapping: delegate.state).formIsValid == false

        sut.setPassword("test")
        try assert(unwrapping: delegate.state).passwordIsValid == true
        try assert(unwrapping: delegate.state).formIsValid == true
    }

    func testSubmissionFailure() async {
        await assert(async: await sut.submit()) == false
        assert(userService.didStore) == false
    }

    func testSubmissionSuccess() async {
        loginService.result = .success(.init())
        await assert(async: await sut.submit()) == true
        assert(userService.didStore) == true
    }

    func testLogout() async {
        await sut.logout()
        assert(userService.didClear) == true
    }
}

class LoginInteractorDelegateSpy: LoginInteractorDelegate {
    var state: LoginRequest.State?
    func didValidateForm(_ state: LoginRequest.State) {
        self.state = state
    }
}

class LoginServiceMock: LoginService {
    struct Error: Swift.Error {}
    var result = Result<LoginResponse, Error>.failure(Error())
    func login(_ request: LoginRequest) async throws -> LoginResponse {
        try result.get()
    }
}

class UserServiceSpy: UserService {
    struct Error: Swift.Error {}
    var didClear: Bool = false
    func clear() async {
        didClear = true
    }

    var didFetch: Bool = false
    func fetch() async throws -> User {
        throw Error()
    }

    var didStore: Bool = false
    func store(_ user: User) async {
        didStore = true
    }
}
