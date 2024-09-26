import KeychainSwift

class StorageService {
    private static let keychain = KeychainSwift()
    
    let shared = StorageService()
    
    static func setValue(value: String, keyType: StorageKeyTypeEnum) {
        keychain.set(value, forKey: keyType.rawValue)
    }
    
    static func getValue(keyType: StorageKeyTypeEnum) -> String? {
        return keychain.get(keyType.rawValue)
    }
    
    static func deleteValue(keyType: StorageKeyTypeEnum) {
        keychain.delete(keyType.rawValue)
    }
}
