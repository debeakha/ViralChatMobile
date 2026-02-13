import Foundation
import SwiftUI

@MainActor
class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentProfile: Profile?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var authMode: AuthMode = .anonymous
    
    init() {
        loadStoredProfile()
    }
    
    private func loadStoredProfile() {
        if let data = UserDefaults.standard.data(forKey: "userProfile"),
           let profile = try? JSONDecoder().decode(Profile.self, from: data) {
            currentProfile = profile
            isAuthenticated = true
        }
    }
    
    func signUp(email: String, password: String, displayName: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let profile = try await AuthService.signUp(email: email, password: password, displayName: displayName)
            currentProfile = profile
            saveProfile(profile)
            isAuthenticated = true
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func signIn(email: String, password: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let profile = try await AuthService.signIn(email: email, password: password)
            currentProfile = profile
            saveProfile(profile)
            isAuthenticated = true
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func anonymousSignIn(displayName: String?) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let profile = try await AuthService.anonymous(displayName: displayName)
            currentProfile = profile
            saveProfile(profile)
            isAuthenticated = true
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func logout() {
        currentProfile = nil
        isAuthenticated = false
        UserDefaults.standard.removeObject(forKey: "userProfile")
    }
    
    private func saveProfile(_ profile: Profile) {
        if let data = try? JSONEncoder().encode(profile) {
            UserDefaults.standard.set(data, forKey: "userProfile")
        }
    }
}
