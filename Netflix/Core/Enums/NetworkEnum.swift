import Foundation

enum NetworkEnum: Error, LocalizedError {
    case badUrl
    case badResponse
    case failedToSerialize
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .badUrl:
            return "The URL was invalid. Please try again later."
        case .badResponse:
            return "There was an error with the server. Please try again later."
        case .failedToSerialize:
            return "The data is invalid. Please try again later."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
