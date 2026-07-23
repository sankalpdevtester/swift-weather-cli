import Foundation

// Define a cache manager for weather data
class WeatherCacheManager {
    // Create a dictionary to store cached data
    private var cache: [String: (data: WeatherData, timestamp: Date)] = [:]
    
    // Define a time to live (TTL) for cached data
    private let ttl: TimeInterval = 30 * 60 // 30 minutes
    
    // Function to get cached data
    func getCachedData(for location: String) -> WeatherData? {
        // Check if data is cached
        if let cachedData = cache[location] {
            // Check if data is still valid (not expired)
            if Date().timeIntervalSince(cachedData.timestamp) < ttl {
                return cachedData.data
            } else {
                // Remove expired data from cache
                cache.removeValue(forKey: location)
            }
        }
        return nil
    }
    
    // Function to cache data
    func cacheData(_ data: WeatherData, for location: String) {
        // Cache data with current timestamp
        cache[location] = (data: data, timestamp: Date())
    }
    
    // Function to clear cache
    func clearCache() {
        cache.removeAll()
    }
}

// Define a protocol for cacheable data
protocol Cacheable {
    var location: String { get }
}

// Extend WeatherData to conform to Cacheable protocol
extension WeatherData: Cacheable {
    var location: String {
        return city
    }
}

// Example usage:
// let cacheManager = WeatherCacheManager()
// let weatherData = WeatherData(city: "New York", temperature: 25)
// cacheManager.cacheData(weatherData, for: weatherData.location)
// let cachedData = cacheManager.getCachedData(for: weatherData.location)
// print(cachedData?.temperature)