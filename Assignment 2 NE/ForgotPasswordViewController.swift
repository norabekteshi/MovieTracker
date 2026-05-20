//
//  ForgotPasswordViewController.swift
//  MovieTracker
//
//  PHASE 1 — TASKS 12, 13.
//  Task 13 leaves the functionality to us; kept minimal here.
//

import UIKit

final class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!

    // TASK 13: our chosen functionality (minimal).
    @IBAction func resetTapped(_ sender: UIButton) {
        print("Password reset requested for: \(emailTextField.text ?? "")")
    }
}
