//
//  UserStore.swift
//  Assignment 2 NE
//
//  Created by Nora Bekteshi on 20.5.26.
//


//
//  UserStore.swift
//  MovieTracker
//
//  Shared in-memory store of registered users. Used by:
//    - Sign Up         -> register(_:)
//    - Login           -> authenticate(username:password:)
//    - Forgot Password -> resetPassword(email:newPassword:)
//
//  Note: users live only while the app is running (no disk storage),
//  which is fine for the assignment — sign up, log in and reset all
//  work within one run of the app.
//
 
import Foundation
 
final class UserStore {
 
    /// Single shared instance used by every screen.
    static let shared = UserStore()
 
    private var users: [User] = []
 
    private init() {
        // Seeded demo account so a correct / incorrect login can be shown
        // immediately. Delete this line if you don't want a pre-made user.
        users.append(User(username: "test",
                          email: "test@test.com",
                          password: "1234"))
    }
 
    /// Sign Up — adds a new user.
    func register(_ user: User) {
        users.append(user)
    }
 
    /// Login — returns the matching user, or nil if no such user exists.
    func authenticate(username: String, password: String) -> User? {
        users.first { $0.username == username && $0.password == password }
    }
 
    /// Forgot Password — updates the password of the account with this email.
    /// Returns true if a matching account was found.
    @discardableResult
    func resetPassword(email: String, newPassword: String) -> Bool {
        guard let index = users.firstIndex(where: { $0.email == email }) else {
            return false
        }
        let existing = users[index]
        users[index] = User(username: existing.username,
                            email: existing.email,
                            password: newPassword)
        return true
    }
}