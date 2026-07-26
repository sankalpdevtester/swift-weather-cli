import Foundation

// Define a cache manager to store and retrieve weather data
class WeatherCacheManager {
    // Create a dictionary to store cached data
    private var cache: [String: (data: WeatherData, timestamp: Date)] = [:]
    
    // Define a time to live (TTL) for cached data
    private let ttl: TimeInterval = 30 * 60 // 30 minutes
    
    // Function to store data in the cache
    func store(data: WeatherData, for location: String) {
        cache[location] = (data: data, timestamp: Date())
    }
    
    // Function to retrieve data from the cache
    func retrieve(for location: String) -> WeatherData? {
        guard let cachedData = cache[location] else { return nil }
        
        // Check if the cached data is still valid (not expired)
        if Date().timeIntervalSince(cachedData.timestamp) < ttl {
            return cachedData.data
        } else {
            // Remove expired data from the cache
            cache.removeValue(forKey: location)
            return nil
        }
    }
    
    // Function to clear the cache
    func clear() {
        cache.removeAll()
    }
}

// Define a protocol for cacheable data
protocol Cacheable {
    var location: String { get }
}

// Extend WeatherData to conform to the Cacheable protocol
extension WeatherData: Cacheable {
    var location: String {
        return city
    }
}

// Example usage:
// let cacheManager = WeatherCacheManager()
// let weatherData = WeatherData(city: "New York", temperature: 25)
// cacheManager.store(data: weatherData, for: weatherData.location)
// let cachedData = cacheManager.retrieve(for: weatherData.location)
// print(cachedData?.city) // prints: Optional("New York")