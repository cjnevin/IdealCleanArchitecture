import AutoLayoutBuilder
import UIKit

@propertyWrapper
public struct LoadingStyle {
    @Lazy public var wrappedValue = configure(LoadingView()) { view in
        view.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        view.alpha = 0
    }
    public init() {}
}

@propertyWrapper
struct ActivityIndicatorContainerStyle {
    @Lazy var wrappedValue = configure(UIView()) { view in
        view.backgroundColor = .black
        view.layer.cornerRadius = 22
    }
}

@propertyWrapper
struct ActivityIndicatorStyle {
    @Lazy var wrappedValue = configure(UIActivityIndicatorView(style: .large)) { indicator in
        indicator.color = .white
        indicator.hidesWhenStopped = true
    }
}

public class LoadingView: UIView {
    @ActivityIndicatorStyle()
    private var activityIndicator: UIActivityIndicatorView
    @ActivityIndicatorContainerStyle()
    private var activityIndicatorContainer: UIView

    public init() {
        super.init(frame: .zero)
        addSubview(activityIndicatorContainer) {
            $0.center == Superview()
            $0.addSubview(activityIndicator) {
                $0.edges(20) == Superview()
            }
        }
    }

    public func show(_ shown: Bool) {
        if shown {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        UIView.animate(withDuration: 0.3) {
            self.alpha = self.activityIndicator.isAnimating ? 1 : 0
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
