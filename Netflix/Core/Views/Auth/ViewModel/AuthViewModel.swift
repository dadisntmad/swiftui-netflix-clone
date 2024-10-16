import SwiftUI
import Observation

@Observable class AuthViewModel {
    var username = ""
    var password = ""
    var errorMessage: String?
    var isLoading = false
    var isAuthenticated = false
    
    var isValid: Bool {
        return !username.trimmingCharacters(in: .whitespaces).isEmpty && !password.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    private let baseUrl = "https://api.themoviedb.org/3/authentication"
    
    private var makeTokenBaseUrl: String {
        return "\(baseUrl)/token/new?api_key=\(ApiKeys.apiKey)"
    }
    
    private var validateTokenBaseUrl: String {
        return "\(baseUrl)/token/validate_with_login?api_key=\(ApiKeys.apiKey)"
    }
    
    private var createSessionBaseUrl: String {
        return "\(baseUrl)/session/new?api_key=\(ApiKeys.apiKey)"
    }
    
    private var signOutBaseUrl: String {
        return "\(baseUrl)/session?api_key=\(ApiKeys.apiKey)"
    }
    
    init() {
        checkAuthentication()
    }
    
    private func createToken() async throws -> String {
        guard let url = URL(string: makeTokenBaseUrl) else { throw NetworkEnum.badUrl }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkEnum.badResponse }
            
            guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else { throw NetworkEnum.failedToSerialize }
            guard let token = json["request_token"] as? String else { throw NetworkEnum.failedToSerialize }
            
            return token
        } catch {
            print("DEBUG: Could not create a token \(error.localizedDescription)")
            isLoading = false
            errorMessage = error.localizedDescription
            throw NetworkEnum.unknown(error)
        }
    }
    
    private func validateToken(username: String, password: String, requestToken: String) async throws -> String {
        guard let url = URL(string: validateTokenBaseUrl) else { throw NetworkEnum.badUrl }
        
        let body: [String: Any] = [
            "username": username,
            "password": password,
            "request_token": requestToken
        ]
        
        let jsonData = try JSONSerialization.data(withJSONObject: body)
        
        do {
            let json =  try await makeRequest(url: url, httpBody: jsonData)
            
            guard let validatedToken = json["request_token"] as? String else { throw NetworkEnum.failedToSerialize }
            
            return validatedToken
            
        } catch {
            print("DEBUG: Could not validate the token \(error.localizedDescription)")
            isLoading = false
            errorMessage = error.localizedDescription
            throw NetworkEnum.unknown(error)
        }
    }
    
    private func createSession(requestToken: String) async throws -> String {
        guard let url = URL(string: createSessionBaseUrl) else { throw NetworkEnum.badUrl }
        
        let body: [String: Any] = [
            "request_token": requestToken
        ]
        
        let jsonData = try JSONSerialization.data(withJSONObject: body)
        
        do {
            
            let json = try await makeRequest(url: url, httpBody: jsonData)
            
            guard let sessionId = json["session_id"] as? String else { throw NetworkEnum.failedToSerialize }
            
            return sessionId
            
        } catch {
            print("DEBUG: Could not create session \(error.localizedDescription)")
            isLoading = false
            errorMessage = error.localizedDescription
            throw NetworkEnum.unknown(error)
        }
    }
    
    private func makeRequest(url: URL, httpBody: Data) async throws -> [String: Any] {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkEnum.badResponse }
        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else { throw NetworkEnum.failedToSerialize }
        
        return json
    }
    
    func login() async throws {
        isLoading = true
        errorMessage = nil
        
        do {
            let token = try await createToken()
            let validatedToken = try await validateToken(username: username, password: password, requestToken: token)
            let sessionId = try await createSession(requestToken: validatedToken)
            
            username = ""
            password = ""
            isLoading = false
            
            if !sessionId.isEmpty {
                isAuthenticated = true
                StorageService.setValue(value: sessionId, keyType: .sessionId)
            }
            
        } catch {
            print("DEBUG: Login failed \(error.localizedDescription)")
            isAuthenticated = false
            errorMessage = error.localizedDescription
            throw NetworkEnum.unknown(error)
        }
    }
    
    
    private func checkAuthentication() {
        let sessionId = StorageService.getValue(keyType: .sessionId)
        isAuthenticated = sessionId != nil
    }
    
    func signOut() async throws {
        isLoading = true
        
        guard let url = URL(string: signOutBaseUrl) else { throw NetworkEnum.badUrl }
        
        let sessionId = StorageService.getValue(keyType: .sessionId)
        
        let body: [String: Any] = [
            "session_id": String(sessionId ?? "")
        ]
        
        let jsonData = try JSONSerialization.data(withJSONObject: body)
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let (_, response) = try await URLSession.shared.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkEnum.badResponse }
            
            StorageService.deleteValue(keyType: .sessionId)
            isAuthenticated = false
            isLoading = false
            
        } catch {
            errorMessage = error.localizedDescription
            throw NetworkEnum.unknown(error)
        }
    }
}
