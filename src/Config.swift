import Foundation

// Define a configuration struct to hold API keys and units
struct Config {
    let apiKey: String
    let units: String
    
    // Initialize the configuration from environment variables
    init() {
        apiKey = ProcessInfo.processInfo.environment["API_KEY"] ?? ""
        units = ProcessInfo.processInfo.environment["UNITS"] ?? "metric"
    }
    
    // Validate the configuration
    func validate() throws {
        if apiKey.isEmpty {
            throw ConfigError.missingApiKey
        }
        
        if units != "metric" && units != "imperial" {
            throw ConfigError.invalidUnits
        }
    }
    
    // Define configuration errors
    enum ConfigError: Error, LocalizedError {
        case missingApiKey
        case invalidUnits
        
        var errorDescription: String? {
            switch self {
            case .missingApiKey:
                return "API key is missing"
            case .invalidUnits:
                return "Invalid units. Supported units are 'metric' and 'imperial'"
            }
        }
    }
}

// Create a singleton instance of the configuration
let config = Config()