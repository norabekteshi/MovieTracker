//
//  User.swift
//  MovieTracker
//
//  PHASE 1 — TASK 5: a model for the User.
//  The assignment lets us choose the attributes ourselves.
//

import Foundation

/// The user object passed between Login → Home (segue)
/// and Sign Up → Home (code).
struct User {
    let username: String
    let email: String
    let password: String

    /// The Login screen only collects a username + password,
    /// so `email` defaults to an empty string there.
    init(username: String, email: String = "", password: String) {
        self.username = username
        self.email = email
        self.password = password
    }
}
