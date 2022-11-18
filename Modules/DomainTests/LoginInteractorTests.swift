import XCTest
import DependencyContainer
import Assert
@testable import Domain

@MainActor
final class LoginInteractorTests: XCTestCase {
    var sut: LoginInteractor!
    var LoginRepository = LoginRepositoryMock()
    var UserRepository = UserRepositorySpy()
    let delegate = LoginInteractorDelegateSpy()

    override func setUp() {
        super.setUp()
        DependencyContainer
            .set(LoginRepository, for: LoginRepositoryDependencyKey.self)
            .set(UserRepository, for: UserRepositoryDependencyKey.self)
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
        await assert(await sut.submit()) == false
        await assert(UserRepository.didStore) == false
    }

    func testSubmissionSuccess() async {
        LoginRepository.result = .success(.init())
        await assert(await sut.submit()) == true
        await assert(UserRepository.didStore) == true
    }

    func testLogout() async {
        await sut.logout()
        await assert(UserRepository.didClear) == true
    }
}

class LoginInteractorDelegateSpy: LoginInteractorDelegate {
    var state: LoginRequest.State?
    func didValidateForm(_ state: LoginRequest.State) {
        self.state = state
    }
}

class LoginRepositoryMock: LoginRepository {
    struct Error: Swift.Error {}
    var result = Result<LoginResponse, Error>.failure(Error())
    func login(_ request: LoginRequest) async throws -> LoginResponse {
        try result.get()
    }
}

class UserRepositorySpy: UserRepository {
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