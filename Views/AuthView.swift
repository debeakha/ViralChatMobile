import SwiftUI

struct AuthView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var email = ""
    @State private var password = ""
    @State private var displayName = ""
    
    var body: some View {
        ZStack {
            Color(hex: "1A1A2E")
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                if authViewModel.authMode != .signIn {
                    TextField("Display Name", text: $displayName)
                        .textFieldStyle(.plain)
                        .padding()
                        .background(Color(hex: "16213E"))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                }
                
                if authViewModel.authMode != .anonymous {
                    TextField("Email", text: $email)
                        .textFieldStyle(.plain)
                        .padding()
                        .background(Color(hex: "16213E"))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .autocapitalization(.none)
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(.plain)
                        .padding()
                        .background(Color(hex: "16213E"))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                }
                
                if let error = authViewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                Button(action: performAuth) {
                    if authViewModel.isLoading {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Text(buttonTitle)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(hex: "E94560"))
                .cornerRadius(8)
                .disabled(authViewModel.isLoading)
                
                Button("Cancel") {
                    dismiss()
                }
                .foregroundColor(Color(hex: "A0A0A0"))
            }
            .padding(32)
        }
    }
    
    var title: String {
        switch authViewModel.authMode {
        case .signUp: return "Create Account"
        case .signIn: return "Sign In"
        case .anonymous: return "Join as Guest"
        }
    }
    
    var buttonTitle: String {
        switch authViewModel.authMode {
        case .signUp: return "Sign Up"
        case .signIn: return "Sign In"
        case .anonymous: return "Join"
        }
    }
    
    func performAuth() {
        Task {
            switch authViewModel.authMode {
            case .signUp:
                await authViewModel.signUp(email: email, password: password, displayName: displayName)
            case .signIn:
                await authViewModel.signIn(email: email, password: password)
            case .anonymous:
                await authViewModel.anonymousSignIn(displayName: displayName.isEmpty ? nil : displayName)
            }
        }
    }
}
