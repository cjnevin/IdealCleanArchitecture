import AutoLayoutBuilder
import Core
import UIKit

public final class HomeViewController: ViewController<HomePresenting> {
    public override init(presenter: HomePresenting) {
        super.init(presenter: presenter)
        tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Home"
    }
}

extension HomeViewController: HomeView {}
