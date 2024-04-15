import SwiftUI

@main
struct MATRIXApp: App {
    @StateObject private var userManager = UserManager() // Create an instance of UserManager
    
    @State private var isLoggedIn = false
    // Remove the newUser argument
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                HomePageView()
                    .environmentObject(userManager) // Pass the userManager as an environment object
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
                    .environmentObject(userManager) // Pass the userManager as an environment object
            }
        }
    }
}



