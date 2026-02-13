import Foundation

struct Profile: Codable, Identifiable {
    let id: String
    var displayName: String
    var email: String?
    var isAnonymous: Bool
    var anonymousId: String?
    var avatarUrl: String?
    var createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case displayName = "display_name"
        case email
        case isAnonymous = "is_anonymous"
        case anonymousId = "anonymous_id"
        case avatarUrl = "avatar_url"
        case createdAt = "created_at"
    }
}

struct Channel: Codable, Identifiable {
    let id: String
    var name: String
    var description: String?
    var createdAt: Date
    var updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct Message: Codable, Identifiable {
    let id: String
    var channelId: String
    var profileId: String?
    var content: String
    var isAnonymous: Bool
    var anonymousName: String?
    var createdAt: Date
    var profiles: Profile?
    
    enum CodingKeys: String, CodingKey {
        case id
        case channelId = "channel_id"
        case profileId = "profile_id"
        case content
        case isAnonymous = "is_anonymous"
        case anonymousName = "anonymous_name"
        case createdAt = "created_at"
        case profiles
    }
}
