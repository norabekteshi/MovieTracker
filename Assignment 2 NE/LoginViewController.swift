//
//  LoginViewController.swift
//  MovieTracker
//
//  PHASE 1 — TASKS 1, 2, 3, 4, 6, 7, 12.
//  Base view controller, root of a UINavigationController, with
//  2 text fields + 3 buttons laid out with Storyboard constraints.
//

import UIKit

final class LoginViewController: UIViewController {

    // TASK 3: the two text fields placed in the Storyboard.
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    // TASK 6: the Login -> Home transition is a Storyboard segue;
    // here we pass the User data to HomeViewController.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toHome",
              let home = segue.destination as? HomeViewController else { return }

        home.user = User(username: usernameTextField.text ?? "",
                         password: passwordTextField.text ?? "")
    }
}
