import Foundation

final class UserStore {

    static let shared = UserStore()

    private var users: [User] = []

    private init() {
        users.append(User(username: "test",
                          email: "test@test.com",
                          password: "1234"))
    }

    func register(_ user: User) {
        users.append(user)
    }

    func authenticate(username: String, password: String) -> User? {
        users.first { $0.username == username && $0.password == password }
    }

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
