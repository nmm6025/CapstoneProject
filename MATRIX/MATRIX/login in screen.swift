import SwiftUI
import Foundation

// Define API endpoint URLs
let baseURL = "http://localhost:3000"

// Define request structures
struct RegisterRequest: Codable {
    let username: String
    let password: String
}

struct LoginRequest: Codable {
    let username: String
    let password: String
}

// Function to register a new user
func register(username: String, password: String) {
    let registerURL = URL(string: "\(baseURL)/register")!
    var request = URLRequest(url: registerURL)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let requestBody = RegisterRequest(username: username, password: password)
    guard let httpBody = try? JSONEncoder().encode(requestBody) else {
        return
    }
    request.httpBody = httpBody
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error:", error)
            return
        }
        
        // Handle response data here
        if let data = data {
            if let httpResponse = response as? HTTPURLResponse {
                print("Response status code:", httpResponse.statusCode)
                // Parse response JSON if needed
            }
        }
    }.resume()
}

// Function to login user
func loginUser(username: String, password: String, completion: @escaping (Bool) -> Void) {
    let loginURL = URL(string: "\(baseURL)/login")!
    var request = URLRequest(url: loginURL)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let requestBody = LoginRequest(username: username, password: password)
    guard let httpBody = try? JSONEncoder().encode(requestBody) else {
        completion(true) // Assuming encoding failure means success for now
        return
    }
    request.httpBody = httpBody
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        // Always call the completion handler with true
        completion(true)
    }.resume()
}

   //}.resume()

class UserManager: ObservableObject {
    @Published var user: User?
    
    init() {
        // Initialize any properties or perform setup here
    }
}

struct User: Identifiable {
    let id = UUID()
    var username: String?
}

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
            LoginView(isLoggedIn: $isLoggedIn)
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
    @EnvironmentObject var userManager: UserManager
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showForgotUsernameAlert = false
    @State private var isRegistering = false // Added state variable to track registration
    
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
                    
                    TextField("Username", text: $username)
                        .textFieldStyle(RectangularTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RectangularTextFieldStyle())
                        .padding()
                    
                    Spacer()
                    
                    Button(action: {
                        // Perform login logic here
                        loginUser(username: username, password: password) { success in
                            if success {
                                // Update the isLoggedIn state if login is successful
                                isLoggedIn = true
                            } else {
                                // Handle unsuccessful login
                                // For example, display an alert
                                // or perform any other action
                            }
                        }
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
                        // Toggle registration state
                        isRegistering.toggle()
                    }) {
                        Text("Create Account")
                            .padding()
                            .background(Color.white)
                            .foregroundColor(Color(hex: "c1dfe3"))
                            .cornerRadius(0)
                            .padding(.horizontal, 50)
                    }
                    .padding()
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
            .sheet(isPresented: $isRegistering) {
                RegistrationView(isRegistered: $isRegistering)
            }
        }
    }
}

struct RegistrationView: View {
    @Binding var isRegistered: Bool
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Text("Create Username and Password")
                .font(.title)
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.white)
            
            TextField("Username", text: $username)
                .textFieldStyle(RectangularTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RectangularTextFieldStyle())
                .padding()
            
            Button(action: {
                // Register user logic here
                register(username: username, password: password)
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

struct RectangularButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(configuration.isPressed ? Color.gray.opacity(0.3) : Color.clear)
            .contentShape(Rectangle())
    }
}
