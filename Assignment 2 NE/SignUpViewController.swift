import UIKit

final class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!

    @IBAction func signUpTapped(_ sender: UIButton) {
        let user = User(username: usernameTextField.text ?? "",
                        email: emailTextField.text ?? "",
                        password: passwordTextField.text ?? "")

        UserStore.shared.register(user)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let home = storyboard.instantiateViewController(
            withIdentifier: "HomeViewController") as? HomeViewController else {
            return
        }
        home.user = user
        navigationController?.pushViewController(home, animated: true)
    }
}
