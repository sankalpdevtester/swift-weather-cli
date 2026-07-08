import Foundation

// Define a weather service to fetch current weather and forecast
class WeatherService {
    let config: Config
    
    // Initialize the weather service with the configuration
    init(config: Config = config) {
        self.config = config
    }
    
    // Fetch the current weather for a given location
    func fetchCurrentWeather(for location: String) async throws -> CurrentWeather {
        // Construct the API URL
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = [
            .init(name: "q", value: location),
            .init(name: "appid", value: config.apiKey),
            .init(name: "units", value: config.units)
        ]
        
        // Fetch the data from the API
        let (data, response) = try await URLSession.shared.data(from: components.url!)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw WeatherError.invalidResponse
        }
        
        // Decode the response into a CurrentWeather object
        let decoder = JSONDecoder()
        return try decoder.decode(CurrentWeather.self, from: data)
    }
    
    // Fetch the 5-day forecast for a given location
    func fetchForecast(for location: String) async throws -> Forecast {
        // Construct the API URL
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = [
            .init(name: "q", value: location),
            .init(name: "appid", value: config.apiKey),
            .init(name: "units", value: config.units)
        ]
        
        // Fetch the data from the API
        let (data, response) = try await URLSession.shared.data(from: components.url!)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw WeatherError.invalidResponse
        }
        
        // Decode the response into a Forecast object
        let decoder = JSONDecoder()
        return try decoder.decode(Forecast.self, from: data)
    }
    
    // Define weather errors
    enum WeatherError: Error, LocalizedError {
        case invalidResponse
        
        var errorDescription: String? {
            switch self {
            case .invalidResponse:
                return "Invalid response from the API"
            }
        }
    }
}

// Define the CurrentWeather and Forecast models
struct CurrentWeather: Codable {
    let main: Main
    let weather: [Weather]
    
    struct Main: Codable {
        let temp: Double
        let feelsLike: Double
        let tempMin: Double
        let tempMax: Double
        let pressure: Int
        let humidity: Int
    }
    
    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
}

struct Forecast: Codable {
    let list: [ForecastItem]
    
    struct ForecastItem: Codable {
        let dt: Int
        let main: Main
        let weather: [Weather]
        
        struct Main: Codable {
            let temp: Double
            let feelsLike: Double
            let tempMin: Double
            let tempMax: Double
            let pressure: Int
            let humidity: Int
        }
        
        struct Weather: Codable {
            let id: Int
            let main: String
            let description: String
            let icon: String
        }
    }
}