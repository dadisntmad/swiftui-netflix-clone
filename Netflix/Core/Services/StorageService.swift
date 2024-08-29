import KeychainSwift

class StorageService {
    private static let keychain = KeychainSwift()
    
    let shared = StorageService()
    
    static func setSessionId(sessionId: String) {
        keychain.set(sessionId, forKey: "sessionId")
    }
    
    static func getSessionId() -> String? {
        return keychain.get("sessionId")
    }
    
    static func deleteSessionId() {
        keychain.delete("sessionId")
    }
}
