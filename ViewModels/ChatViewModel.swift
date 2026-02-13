import Foundation
import SwiftUI

@MainActor
class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var newMessage = ""
    @Published var isLoading = false
    var channelId: String = ""
    var profileId: String? = nil
    
    func fetchMessages() {
        // Load from UserDefaults
        if let data = UserDefaults.standard.data(forKey: "userProfile"),
           let profile = try? JSONDecoder().decode(Profile.self, from: data) {
            profileId = profile.id
        }
        // Simulated - in production call API
        isLoading = false
    }
    
    func sendMessage() {
        guard !newMessage.trimmingCharacters(in: .whitespaces).isEmpty,
              let profileId = profileId else { return }
        
        let message = Message(
            id: UUID().uuidString,
            channelId: channelId,
            profileId: profileId,
            content: newMessage,
            isAnonymous: false,
            anonymousName: nil,
            createdAt: Date(),
            profiles: nil
        )
        
        messages.append(message)
        newMessage = ""
    }
}
