import UIKit

final class SignUpViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        wireButtons()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    private func wireButtons() {
        findButton(title: "Sign Up")?.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        findButton(title: "Log in")?.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }

    @objc private func handleSignUp() {
        guard validateFields() else { return }
        let home = HomeViewController()
        navigationController?.pushViewController(home, animated: true)
    }

    @objc private func handleLogin() {
        navigationController?.popViewController(animated: true)
    }

    private func validateFields() -> Bool {
        let fields = view.findSubviews(ofType: UITextField.self)
        guard !fields.isEmpty else {
            showSimpleAlert(title: "Missing Fields", message: "No input fields were found. Please add text fields to the Sign Up screen.")
            return false
        }
        let hasEmpty = fields.contains { ($0.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
        if hasEmpty {
            showSimpleAlert(title: "Missing Info", message: "Please fill in all fields before signing up.")
            return false
        }
        return true
    }

    private func findButton(title: String) -> UIButton? {
        return view.findSubview(ofType: UIButton.self) { $0.currentTitle == title }
    }
}
