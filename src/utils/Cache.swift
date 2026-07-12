// Cache.swift
// In-memory cache with TTL for API responses

import Foundation

class Cache {
    // Cache storage
    private var cache: [String: (data: Data, timestamp: Date)] = [:]
    
    // TTL (time to live) in seconds
    private let ttl: TimeInterval
    
    init(ttl: TimeInterval = 300) { // 5 minutes default TTL
        self.ttl = ttl
    }
    
    // Get cached data for a given key
    func get(forKey key: String) -> Data? {
        guard let cachedData = cache[key] else {
            return nil
        }
        
        // Check if cached data is still valid (not expired)
        let now = Date()
        if now.timeIntervalSince(cachedData.timestamp) > ttl {
            // Remove expired data from cache
            cache.removeValue(forKey: key)
            return nil
        }
        
        return cachedData.data
    }
    
    // Set cached data for a given key
    func set(forKey key: String, data: Data) {
        cache[key] = (data: data, timestamp: Date())
    }
    
    // Remove cached data for a given key
    func remove(forKey key: String) {
        cache.removeValue(forKey: key)
    }
    
    // Clear entire cache
    func clear() {
        cache.removeAll()
    }
}

// Example usage:
// let cache = Cache()
// cache.set(forKey: "weather_data", data: Data("example_data".utf8))
// let cachedData = cache.get(forKey: "weather_data")

// Integration with WeatherService.swift
extension WeatherService {
    func getWeather(for city: String, cache: Cache) -> Data? {
        let cacheKey = "weather_\(city)"
        if let cachedData = cache.get(forKey: cacheKey) {
            return cachedData
        }
        
        // Fetch weather data from API
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)") else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching weather data: \(error)")
                return
            }
            
            if let data = data {
                cache.set(forKey: cacheKey, data: data)
            }
        }
        task.resume()
        
        return nil // Return nil if no cached data is available
    }
}