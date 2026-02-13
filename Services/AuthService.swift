import Foundation

struct AuthService {
    static func signUp(email: String, password: String, displayName: String) async throws -> Profile {
        let body = ["email": email, "password": password, "displayName": displayName]
        let data = try JSONEncoder().encode(body)
        
        struct SignUpResponse: Decodable {
            let profile: Profile
            let message: String
        }
        
        let response: SignUpResponse = try await APIClient.request(
            endpoint: "/api/auth/signup",
            method: "POST",
            body: data
        )
        
        return response.profile
    }
    
    static func signIn(email: String, password: String) async throws -> Profile {
        let body = ["email": email, "password": password]
        let data = try JSONEncoder().encode(body)
        
        struct SignInResponse: Decodable {
            let profile: Profile
        }
        
        let response: SignInResponse = try await APIClient.request(
            endpoint: "/api/auth/signin", 
            method: "POST",
            body: data
        )
        
        return response.profile
    }
    
    static func anonymous(displayName: String?) async throws -> Profile {
        var body: [String: String] = [:]
        if let displayName = displayName {
            body["displayName"] = displayName
        }
        let data = try JSONEncoder().encode(body)
        
        struct AnonymousResponse: Decodable {
            let profile: Profile
            let anonymousId: String
            
            enum CodingKeys: String, CodingKey {
                case profile
                case anonymousId = "anonymousId"
            }
        }
        
        let response: AnonymousResponse = try await APIClient.request(
            endpoint: "/api/auth/anonymous",
            method: "POST",
            body: data
        )
        
        return response.profile
    }
}
