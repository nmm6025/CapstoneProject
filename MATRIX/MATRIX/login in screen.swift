import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb & 0xFF0000) >> 16) / 255.0
        let g = Double((rgb & 0xFF00) >> 8) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}

struct User: Identifiable {
    let id = UUID()
    var username: String?
    let email: String
}


struct ContentView: View {
    var body: some View {
        ContentViewWrapper()
    }
}

struct ContentViewWrapper: View {
    @State private var isLoggedIn = false
    @StateObject private var userManager = UserManager()

    var body: some View {
        if isLoggedIn {
            HomePageView()
                .background(Color(hex: "c1dfe3"))
                .ignoresSafeArea()
                .environmentObject(userManager)
        } else {
            TabView {
                LoginView(isLoggedIn: $isLoggedIn, newUser: .constant(User(email: ""))) // Pass User with nil values
                    .tabItem {
                        Label("Login", systemImage: "person.fill")
                    }
            }
            .background(Color(hex: "c1dfe3"))
            .ignoresSafeArea()
            .environmentObject(userManager)
        }
    }
}




struct RectangularTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color.white)
            .cornerRadius(0)
    }
}

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @Binding var newUser: User?
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showForgotUsernameAlert = false
    @State private var showRegistration = false
    @State private var showEmailSignUp = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 5) {
                Image("c1dfe3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 125)
                    .clipped()
                    .padding(.top, 50)
                
                VStack {
                    Text("MATRIX")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(RectangularTextFieldStyle()) // Apply custom rectangular text field style
                        .padding()
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RectangularTextFieldStyle()) // Apply custom rectangular text field style
                        .padding()
                    
                    Spacer()
                    
                    Button(action: {
                        // Perform login logic here
                        loginUser()
                    }) {
                        Text("Login")
                            .padding()
                            .background(Color.white)
                            .foregroundColor(Color(hex: "c1dfe3"))
                            .cornerRadius(0)
                            .padding(.horizontal, 50)
                    }
                    .padding()
                    .buttonStyle(RectangularButtonStyle())
                    
                    Button(action: {
                        // Show registration form
                        showRegistration = true
                    }) {
                        Text("Create Account")
                            .padding()
                            .background(Color.white)
                            .foregroundColor(Color(hex: "c1dfe3"))
                            .cornerRadius(0)
                            .padding(.horizontal, 50)
                    }
                    .sheet(isPresented: $showRegistration) {
                        RegistrationView(isRegistered: $showRegistration, newUser: $newUser)
                    }
                    .buttonStyle(RectangularButtonStyle())
                    
                    Button(action: {
                        // Show email sign-up form
                        showEmailSignUp = true
                    }) {
                        Text("Link Email")
                            .padding()
                            .background(Color.white)
                            .foregroundColor(Color(hex: "c1dfe3"))
                            .cornerRadius(0)
                            .padding(.horizontal, 50)
                    }
                    .sheet(isPresented: $showEmailSignUp) {
                        EmailSignUpView(isSignedUp: $showEmailSignUp, newUser: $newUser)
                    }
                    .buttonStyle(RectangularButtonStyle())
                    
                    Button(action: {
                        // Perform forgot username logic here
                        showForgotUsernameAlert = true
                    }) {
                        Text("Forgot Password?")
                            .padding()
                            .foregroundColor(.white)
                            .font(.caption)
                    }
                    .alert(isPresented: $showForgotUsernameAlert) {
                        Alert(title: Text("Forgot Password?"), message: Text("Please contact support for assistance."), dismissButton: .default(Text("OK")))
                    }
                    .buttonStyle(RectangularButtonStyle())
                    
                    Spacer()
                }
                .padding()
                .background(Color(hex: "c1dfe3").opacity(0.8))
                .cornerRadius(20)
                .padding()
            }
            .navigationBarHidden(true)
        }
    }
    
    func loginUser() {
        // Simulated login logic
        isLoggedIn = true
    }
}

struct RegistrationView: View {
    @Binding var isRegistered: Bool
    @Binding var newUser: User?
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var username: String = ""
    
    var body: some View {
        VStack {
            Text("Create Username and Password")
                .font(.title)
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.white)
            
            TextField("Email", text: $email)
                .textFieldStyle(RectangularTextFieldStyle()) // Apply custom rectangular text field style
                .padding()
            
            TextField("Username", text: $username)
                .textFieldStyle(RectangularTextFieldStyle()) // Apply custom rectangular text field style
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RectangularTextFieldStyle()) // Apply custom rectangular text field style
                .padding()
            
            Button(action: {
                // Register user logic here
            }) {
                Text("Register")
                    .padding()
                    .background(Color.white)
                    .foregroundColor(Color(hex: "c1dfe3"))
                    .cornerRadius(0)
                    .padding(.horizontal, 50)
            }
            .padding()
            .buttonStyle(RectangularButtonStyle())
        }
        .navigationBarTitle("Registration")
        .navigationBarItems(trailing: Button("Cancel", action: {
            isRegistered = false
        }))
        .background(Color(hex: "c1dfe3"))
        .ignoresSafeArea()
    }
}

struct EmailSignUpView: View {
    @Binding var isSignedUp: Bool
    @Binding var newUser: User?
    @State private var email: String = ""
    
    var body: some View {
        VStack {
            Text("Sign Up with Email")
                .font(.title)
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.white)
            
            TextField("Email", text: $email)
                .textFieldStyle(RectangularTextFieldStyle()) // Apply custom rectangular text field style
                .padding()
            
            Button(action: {
                // Sign up with email logic here
            }) {
                Text("Sign Up")
                    .padding()
                    .background(Color.white)
                    .foregroundColor(Color(hex: "c1dfe3"))
                    .cornerRadius(0)
                    .padding(.horizontal, 50)
            }
            .padding()
            .buttonStyle(RectangularButtonStyle())
        }
        .navigationBarTitle("Email Sign Up")
        .navigationBarItems(trailing: Button("Cancel", action: {
            isSignedUp = false
        }))
        .background(Color(hex: "c1dfe3"))
        .ignoresSafeArea()
    }
}

class UserManager: ObservableObject {
    @Published var user: User?
    // Other properties and methods
}

struct MessagesView: View {
    var selectedUser: User?
    
    var body: some View {
        Text("Messages View Placeholder")
    }
}

// Custom button style for rectangular buttons
struct RectangularButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(configuration.isPressed ? Color.gray.opacity(0.3) : Color.clear)
            .contentShape(Rectangle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
