import UIKit

extension UIView {
    func findSubview<T: UIView>(ofType type: T.Type, where predicate: ((T) -> Bool)? = nil) -> T? {
        if let view = self as? T, predicate?(view) ?? true {
            return view
        }
        for subview in subviews {
            if let match: T = subview.findSubview(ofType: type, where: predicate) {
                return match
            }
        }
        return nil
    }

    func findSubviews<T: UIView>(ofType type: T.Type) -> [T] {
        var matches: [T] = []
        if let view = self as? T {
            matches.append(view)
        }
        for subview in subviews {
            matches.append(contentsOf: subview.findSubviews(ofType: type))
        }
        return matches
    }
}
