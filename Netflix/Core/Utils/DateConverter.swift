import Foundation

class DateConverter {
    static func getReleaseDate(dateString: String, isDay: Bool) -> String {
        var result = ""
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.date(from: dateString)
        
        if isDay {
            dateFormatter.dateFormat = "dd"
            
            result = dateFormatter.string(from: date ?? Date())
        } else {
            dateFormatter.dateFormat = "MMM"
            
            result = dateFormatter.string(from: date ?? Date())
        }
        
        return result
    }
}

