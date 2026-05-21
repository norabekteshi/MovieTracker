import UIKit

final class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!

    @IBAction func resetTapped(_ sender: UIButton) {
        let email = emailTextField.text ?? ""
        let newPassword = newPasswordTextField.text ?? ""

        let success = UserStore.shared.resetPassword(email: email,
                                                     newPassword: newPassword)
        print(success ? "Password reset for \(email)."
                      : "No account found for \(email).")
    }
}
