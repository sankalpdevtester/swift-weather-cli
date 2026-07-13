import Foundation

// Define a struct to hold the current weather data
struct CurrentWeather: Codable {
    let temperature: Double
    let feelsLike: Double
    let humidity: Int
    let weatherDescription: String
    let windSpeed: Double
    let windDirection: String
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLike = "feels_like"
        case humidity
        case weatherDescription = "description"
        case windSpeed = "speed"
        case windDirection = "deg"
    }
}

// Define a struct to hold the forecast weather data
struct ForecastWeather: Codable {
    let date: Date
    let temperature: Double
    let feelsLike: Double
    let humidity: Int
    let weatherDescription: String
    let windSpeed: Double
    let windDirection: String
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temperature = "temp"
        case feelsLike = "feels_like"
        case humidity
        case weatherDescription = "description"
        case windSpeed = "speed"
        case windDirection = "deg"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decode(Date.self, forKey: .date)
        temperature = try container.decode(Double.self, forKey: .temperature)
        feelsLike = try container.decode(Double.self, forKey: .feelsLike)
        humidity = try container.decode(Int.self, forKey: .humidity)
        weatherDescription = try container.decode(String.self, forKey: .weatherDescription)
        windSpeed = try container.decode(Double.self, forKey: .windSpeed)
        windDirection = try container.decode(String.self, forKey: .windDirection)
    }
}

// Define a struct to hold the API response data
struct WeatherData: Codable {
    let currentWeather: CurrentWeather
    let forecastWeather: [ForecastWeather]
    
    enum CodingKeys: String, CodingKey {
        case currentWeather = "current"
        case forecastWeather = "forecast"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        currentWeather = try container.decode(CurrentWeather.self, forKey: .currentWeather)
        forecastWeather = try container.decode([ForecastWeather].self, forKey: .forecastWeather)
    }
}