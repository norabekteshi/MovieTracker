import UIKit

final class LogInViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        wireButtons()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    private func wireButtons() {
        findButton(title: "Log In")?.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        findButton(title: "Sign Up")?.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        findButton(title: "Forgot Password?")?.addTarget(self, action: #selector(handleForgot), for: .touchUpInside)
    }

    @objc private func handleLogin() {
        let home = HomeViewController()
        navigationController?.pushViewController(home, animated: true)
    }

    @objc private func handleSignUp() {
        let signUp: SignUpViewController = SignUpViewController.instantiate()
        navigationController?.pushViewController(signUp, animated: true)
    }

    @objc private func handleForgot() {
        let forgot: ForgotPasswordViewController = ForgotPasswordViewController.instantiate()
        navigationController?.pushViewController(forgot, animated: true)
    }

    private func findButton(title: String) -> UIButton? {
        return view.findSubview(ofType: UIButton.self) { $0.currentTitle == title }
    }
}
