import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        TabView {
            ChannelListView()
                .tabItem {
                    Label("Chats", systemImage: "bubble.left.and.bubble.right")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
        .tint(Color(hex: "E94560"))
    }
}

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            Color(hex: "1A1A2E")
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(Color(hex: "E94560"))
                
                if let profile = authViewModel.currentProfile {
                    Text(profile.displayName)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    if profile.isAnonymous {
                        Text("Guest Account")
                            .foregroundColor(Color(hex: "A0A0A0"))
                    }
                }
                
                Spacer()
                
                Button(action: {
                    authViewModel.logout()
                }) {
                    Text("Logout")
                        .foregroundColor(.red)
                }
            }
            .padding(.top, 48)
        }
    }
}
