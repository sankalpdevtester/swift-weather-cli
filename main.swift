import AsyncHTTPClient
import ArgumentParser
import Logging

// Define a logger
let logger = Logger(label: "SwiftWeatherCLI")

// Define a struct to hold the weather data
struct WeatherData: Codable {
    let main: Main
    let weather: [Weather]
    let name: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// Define a struct to hold the forecast data
struct ForecastData: Codable {
    let list: [List]
}

struct List: Codable {
    let main: Main
    let weather: [Weather]
    let dt_txt: String
}

// Define a command-line tool
struct WeatherCLI: ParsableCommand {
    @Argument(help: "The city name")
    var city: String

    @Argument(help: "The API key")
    var apiKey: String

    @Argument(help: "The unit of measurement (metric or imperial)")
    var unit: String

    mutating func run() async throws {
        // Create an HTTP client
        let httpClient = HTTPClient(eventLoopGroup: .init(numberOfThreads: 1))

        // Create a URL for the API request
        var url = URL(string: "https://api.openweathermap.org/data/2.5/weather")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: unit)
        ]
        url = components.url!

        // Make the API request
        let request = HTTPClient.Request(url: url, method: .GET)
        let response = try await httpClient.execute(request, deadline: .now() + .seconds(10))

        // Check the response status code
        guard response.status == .ok else {
            logger.error("Failed to retrieve weather data: \(response.status)")
            return
        }

        // Decode the response data
        let weatherData = try JSONDecoder().decode(WeatherData.self, from: response.body)

        // Print the weather data
        print("Current weather in \(weatherData.name):")
        print("Temperature: \(weatherData.main.temp)°\(unit == "metric" ? "C" : "F")")
        print("Feels like: \(weatherData.main.feels_like)°\(unit == "metric" ? "C" : "F")")
        print("Description: \(weatherData.weather[0].description)")

        // Create a URL for the forecast API request
        url = URL(string: "https://api.openweathermap.org/data/2.5/forecast")!
        components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: unit)
        ]
        url = components.url!

        // Make the forecast API request
        request = HTTPClient.Request(url: url, method: .GET)
        response = try await httpClient.execute(request, deadline: .now() + .seconds(10))

        // Check the response status code
        guard response.status == .ok else {
            logger.error("Failed to retrieve forecast data: \(response.status)")
            return
        }

        // Decode the response data
        let forecastData = try JSONDecoder().decode(ForecastData.self, from: response.body)

        // Print the forecast data
        print("5-day forecast:")
        for forecast in forecastData.list {
            print("Date: \(forecast.dt_txt)")
            print("Temperature: \(forecast.main.temp)°\(unit == "metric" ? "C" : "F")")
            print("Description: \(forecast.weather[0].description)")
            print()
        }
    }
}

// Run the command-line tool
WeatherCLI.main()