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
        let home = HomeViewController()
        navigationController?.pushViewController(home, animated: true)
    }

    @objc private func handleLogin() {
        navigationController?.popViewController(animated: true)
    }

    private func findButton(title: String) -> UIButton? {
        return view.findSubview(ofType: UIButton.self) { $0.currentTitle == title }
    }
}
