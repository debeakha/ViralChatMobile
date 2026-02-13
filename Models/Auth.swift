import Foundation

enum AuthMode {
    case signIn
    case signUp
    case anonymous
}

struct AuthResponse: Codable {
    let user: User?
    let profile: Profile?
    let message: String?
    let session: Session?
}

struct User: Codable {
    let id: String
    let email: String?
}

struct Session: Codable {
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}
