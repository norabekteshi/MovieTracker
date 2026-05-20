//
//  SignUpViewController.swift
//  MovieTracker
//
//  PHASE 1 — TASKS 7, 8, 9.
//  Reached from Login via a Storyboard segue; its form has Storyboard
//  constraints. The Sign Up -> Home transition is done through code.
//

import UIKit

final class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!

    // TASK 9: Sign Up -> Home THROUGH CODE, passing the User data.
    @IBAction func signUpTapped(_ sender: UIButton) {
        let user = User(username: usernameTextField.text ?? "",
                             email: emailTextField.text ?? "",
                             password: passwordTextField.text ?? "")
      
             UserStore.shared.register(user)   // Sign Up creates the user
      
             let storyboard = UIStoryboard(name: "Main", bundle: nil)
             guard let home = storyboard.instantiateViewController(
                 withIdentifier: "HomeViewController") as? HomeViewController else {
                 return
        }
        home.user = user
                navigationController?.pushViewController(home, animated: true)
    }
}
