import Foundation
import SwiftUI

@MainActor
class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var newMessage = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    var channelId: String = ""
    var profileId: String? = nil
    var isAnonymous: Bool = false
    var anonymousName: String? = nil
    
    func fetchMessages() {
        guard !channelId.isEmpty else { return }
        
        if let data = UserDefaults.standard.data(forKey: "userProfile"),
           let profile = try? JSONDecoder().decode(Profile.self, from: data) {
            profileId = profile.id
            isAnonymous = profile.isAnonymous
            anonymousName = profile.displayName
        }
        
        isLoading = true
        
        Task {
            do {
                let fetchedMessages: MessagesResponse = try await APIClient.request(
                    endpoint: "/api/messages?channelId=\(channelId)"
                )
                await MainActor.run {
                    self.messages = fetchedMessages.messages
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                }
            }
            await MainActor.run {
                self.isLoading = false
            }
        }
    }
    
    func sendMessage() {
        guard !newMessage.trimmingCharacters(in: .whitespaces).isEmpty,
              let profileId = profileId else { return }
        
        let body: [String: Any] = [
            "channelId": channelId,
            "content": newMessage,
            "profileId": profileId,
            "isAnonymous": isAnonymous,
            "anonymousName": anonymousName ?? ""
        ]
        
        guard let data = try? JSONSerialization.data(withJSONObject: body) else { return }
        
        Task {
            do {
                let response: MessageResponse = try await APIClient.request(
                    endpoint: "/api/messages",
                    method: "POST",
                    body: data
                )
                await MainActor.run {
                    self.messages.append(response.message)
                    self.newMessage = ""
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

struct MessagesResponse: Decodable {
    let messages: [Message]
}

struct MessageResponse: Decodable {
    let message: Message
}
