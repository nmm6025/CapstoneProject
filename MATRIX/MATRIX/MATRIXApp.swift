import SwiftUI

@main
struct MATRIXApp: App {
    @StateObject private var userManager = UserManager() // Create an instance of UserManager
    
    @State private var isLoggedIn = false
    @State private var newUser: User?
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                HomePageView()
                    .environmentObject(userManager) // Pass the userManager as an environment object
            } else {
                LoginView(isLoggedIn: $isLoggedIn, newUser: $newUser)
                    .environmentObject(userManager) // Pass the userManager as an environment object
            }
        }
    }
}



