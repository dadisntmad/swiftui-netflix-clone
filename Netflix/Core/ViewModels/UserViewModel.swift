import SwiftUI
import Observation

@Observable class UserViewModel {
    private var baseUrl = "https://api.themoviedb.org/3/account"
    
    var user: UserModel?
    
    init() {
        Task {
            user = try await getCurrentUser()
        }
    }
    
    private func getCurrentUser() async throws -> UserModel {
        let sessionId = StorageService.getSessionId()
        
        guard let sessionId = sessionId else { throw URLError(.unknown) }
        
        guard let url = URL(string: "\(baseUrl)?api_key=\(ApiKeys.apiKey)&session_id=\(sessionId)") else { throw NetworkEnum.badUrl }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkEnum.badResponse }
            
            let user = try JSONDecoder().decode(UserModel.self, from: data)
            return user
            
        } catch {
            print("DEBUG: Could not get current user \(error.localizedDescription)")
            throw NetworkEnum.unknown(error)
        }
    }
}
