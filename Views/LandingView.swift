import SwiftUI

struct LandingView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showAuthSheet = false
    
    var body: some View {
        ZStack {
            Color(hex: "1A1A2E")
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Spacer()
                
                VStack(spacing: 16) {
                    Image(systemName: "bubble.left.and.bubble.right.fill")
                        .font(.system(size: 64))
                        .foregroundColor(Color(hex: "E94560"))
                    
                    Text("ViralChat")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Connect with your community in real-time")
                        .font(.title3)
                        .foregroundColor(Color(hex: "A0A0A0"))
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                
                VStack(spacing: 12) {
                    Button(action: { authViewModel.authMode = .signUp; showAuthSheet = true }) {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: "E94560"))
                            .cornerRadius(12)
                    }
                    
                    Button(action: { authViewModel.authMode = .signIn; showAuthSheet = true }) {
                        Text("Sign In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: "16213E"))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(hex: "E94560"), lineWidth: 2)
                            )
                    }
                    
                    Button(action: { authViewModel.authMode = .anonymous; showAuthSheet = true }) {
                        Text("Join as Guest")
                            .font(.headline)
                            .foregroundColor(Color(hex: "A0A0A0"))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.clear)
                    }
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 48)
            }
        }
        .sheet(isPresented: $showAuthSheet) {
            AuthView()
                .environmentObject(authViewModel)
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
