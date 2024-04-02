import Foundation
import Combine // Import Combine framework for @Published property wrapper

struct Expense {
    let userId: String
    let category: String
    let amount: Double
}

class DatabaseManager: ObservableObject { // Make DatabaseManager a class and conform to ObservableObject
    static let shared = DatabaseManager()
    
    @Published private var users: [User] = [] // Use @Published for properties you want to observe
    @Published private var expenses: [Expense] = []
    
    // User Authentication
    func createUser(username: String, email: String) -> User? {
        // Mock implementation for creating a new user
        let newUser = User(username: username, email: email) // Use memberwise initializer
        users.append(newUser)
        return newUser
    }
    
    func loginUser(username: String, password: String) -> User? {
        // Mock implementation for user login
        return users.first { $0.username == username }
    }
    
    // Expense Management
    func addExpense(userId: String, category: String, amount: Double) {
        // Mock implementation for adding an expense
        let newExpense = Expense(userId: userId, category: category, amount: amount)
        expenses.append(newExpense)
    }
    
    func getExpensesForUser(userId: String) -> [Expense] {
        // Mock implementation for fetching expenses for a user
        return expenses.filter { $0.userId == userId }
    }
    
    // Report Generation (Example: Total expenses for a user)
    func getTotalExpensesForUser(userId: String) -> Double {
        // Mock implementation for calculating total expenses
        let userExpenses = getExpensesForUser(userId: userId)
        return userExpenses.reduce(0) { $0 + $1.amount }
    }
}
