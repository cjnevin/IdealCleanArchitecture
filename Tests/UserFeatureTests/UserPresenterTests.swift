import XCTest
import Assert
@testable import UserFeature
import UserService

@MainActor
class UserPresenterTests: XCTestCase {
    var sut: UserPresenter!
    private var router = UserRouterSpy()
    private var interactor = UserInteractorMock()
    private var delegate = UserDelegateSpy()
    private var view = UserViewSpy()
    
    override func setUp() {
        super.setUp()
        sut = UserPresenter(
            interactor: interactor,
            router: router
        )
        sut.view = view
        sut.delegate = delegate
    }
    
    func testPrepareThrowsIfInteractorThrows() async throws {
        do {
            try await sut.prepare()
            assertionFailure("Expected error to be thrown")
        } catch {
            assert(error is UserInteractorMock.Error) == true
        }
    }
    
    func testPrepareDoesNotThrowIfInteractorDoesNotThrow() async throws {
        let user = User()
        interactor.user = user
        do {
            try await sut.prepare()
            assert(view.loadingStates) == [true, false]
            try assert(unwrapping: view.configuredStates.first) {
                $0.id == user.id.uuidString
                $0.age == "18"
                $0.name.isEmpty == true
            }
        } catch {
            assertionFailure("Expected no error to be thrown")
        }
    }
    
    func testLogout() async {
        assert(view.loadingStates.isEmpty) == true
        assert(delegate.didLogout) == false
        assert(router.didLogout) == false
        await sut.logout()
        assert(view.loadingStates) == [true, false]
        assert(delegate.didLogout) == true
        assert(router.didLogout) == true
    }
}

private class UserViewSpy: UserView {
    var configuredStates: [UserViewModel] = []
    func configure(with vm: UserViewModel) {
        configuredStates.append(vm)
    }

    var loadingStates: [Bool] = []
    func showLoading(_ shown: Bool) {
        loadingStates.append(shown)
    }
}

private class UserInteractorMock: UserInteracting {
    struct Error: Swift.Error {}
    var user: User?
    func fetchUser() async throws -> User {
        guard let user = user else {
            throw Error()
        }
        return user
    }
}

private class UserDelegateSpy: UserDelegate {
    var didLogout: Bool = false
    func logout() async {
        didLogout = true
    }
}

private class UserRouterSpy: UserRoute, LogoutRoute {
    var didStartUser: Bool = false
    func startUser(with delegate: UserDelegate) {
        didStartUser = true
    }
    
    var didLogout: Bool = false
    func logout() {
        didLogout = true
    }
}
