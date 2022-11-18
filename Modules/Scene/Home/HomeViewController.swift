import AutoLayoutBuilder
import Presentation
import UIKit

@MainActor
public final class HomeViewController: ViewController<HomePresenting> {
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Home"
    }
}

extension HomeViewController: HomeView {}
