//
//  ForgotPasswordViewController.swift
//  MovieTracker
//
//  PHASE 1 — TASKS 12, 13.
//  Layout: Email field, New Password field, Confirm Password field,
//  a Reset button, and a Back button (Back is a Storyboard segue to Login).
//  Task 13 leaves the functionality to us; kept minimal here.
//

import UIKit

final class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!

    // TASK 13: our chosen functionality (minimal, no alerts).
    @IBAction func resetTapped(_ sender: UIButton) {
        print("Password reset for \(emailTextField.text ?? "") — new password set.")
    }

    // The Back button is wired as a Storyboard segue to Login,
    // so it needs no code here.
}
