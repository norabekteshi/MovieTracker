import UIKit

extension UIViewController {
    static var storyboardID: String { String(describing: self) }

    static func instantiate<T: UIViewController>(from storyboardName: String = "Main") -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("Storyboard ID \(storyboardID) not found in \(storyboardName).storyboard")
        }
        return viewController
    }
}
