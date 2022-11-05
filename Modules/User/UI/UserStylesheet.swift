import CommonUI
import UIKit

@propertyWrapper
struct IDStyle {
    @Lazy var wrappedValue = configure(UILabel()) { label in
        label.font = .systemFont(ofSize: 10)
        label.textColor = .purple
        label.textAlignment = .center
    }
}

@propertyWrapper
struct NameStyle {
    @Lazy var wrappedValue = configure(UILabel()) { label in
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
    }
}

@propertyWrapper
struct AgeStyle {
    @Lazy var wrappedValue = configure(UILabel()) { label in
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .blue
        label.textAlignment = .center
    }
}
