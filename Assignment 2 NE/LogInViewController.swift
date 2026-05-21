import UIKit

final class LogInViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func shouldPerformSegue(withIdentifier identifier: String,
                                     sender: Any?) -> Bool {
        guard identifier == "toHome" else { return true }

        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        if UserStore.shared.authenticate(username: username,
                                         password: password) != nil {
            return true
        }
        print("Login failed: no matching user for \"\(username)\".")
        return false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toHome",
              let home = segue.destination as? HomeViewController else { return }

        home.user = UserStore.shared.authenticate(
            username: usernameTextField.text ?? "",
            password: passwordTextField.text ?? "")
    }
}
