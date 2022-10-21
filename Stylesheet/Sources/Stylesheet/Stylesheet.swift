import AutoLayoutBuilder
import UIKit
import WrappedTypes

@propertyWrapper
public struct LoadingStyle {
    public var wrappedValue: LoadingView
    public init(_ view: LoadingView = .init()) {
        wrappedValue = view
        view.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        view.alpha = 0
    }
}

@propertyWrapper
struct ActivityIndicatorContainerStyle {
    var wrappedValue: UIView
    init(_ view: UIView = .init()) {
        wrappedValue = view
        view.backgroundColor = .black
        view.layer.cornerRadius = 22
    }
}

@propertyWrapper
struct ActivityIndicatorStyle {
    var wrappedValue: UIActivityIndicatorView

    init(_ view: UIActivityIndicatorView = .init(style: UIActivityIndicatorView.Style.large)) {
        wrappedValue = view
        view.color = .white
        view.hidesWhenStopped = true
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
