//
//  LoginViewController.swift
//  MovieTracker
//
//  PHASE 1 — TASKS 1, 2, 3, 4, 6, 7, 12.
//  Base view controller, root of a UINavigationController, with
//  2 text fields + 3 buttons laid out with Storyboard constraints.
//

import UIKit

final class LogInViewController: UIViewController {

    // TASK 3: the two text fields placed in the Storyboard.
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    // TASK 6: only allow the Login -> Home segue when the username +
        // password match a registered user. The Sign Up / Forgot segues
        // are always allowed through.
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
     
        // TASK 6: pass the logged-in User to Home through the segue.
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard segue.identifier == "toHome",
                  let home = segue.destination as? HomeViewController else { return }
     
            home.user = UserStore.shared.authenticate(
                username: usernameTextField.text ?? "",
                password: passwordTextField.text ?? "")
        }
    }

