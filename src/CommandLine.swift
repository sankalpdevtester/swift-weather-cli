import Foundation

// Define a command-line interface to display weather information
class CommandLine {
    let weatherService: WeatherService
    
    // Initialize the command-line interface with the weather service
    init(weatherService: WeatherService = WeatherService()) {
        self.weatherService = weatherService
    }
    
    // Display the current weather for a given location
    func displayCurrentWeather(for location: String) async throws {
        let currentWeather = try await weatherService.fetchCurrentWeather(for: location)
        print("Current weather in \(location):")
        print("Temperature: \(currentWeather.main.temp)°C")
        print("Feels like: \(currentWeather.main.feelsLike)°C")
        print("Weather: \(currentWeather.weather.first?.main ?? "")")
    }
    
    // Display the 5-day forecast for a given location
    func displayForecast(for location: String) async throws {
        let forecast = try await weatherService.fetchForecast(for: location)
        print("5-day forecast for \(location):")
        for (index, forecastItem) in forecast.list.enumerated() {
            print("Day \(index + 1):")
            print("Temperature: \(forecastItem.main.temp)°C")
            print("Feels like: \(forecastItem.main.feelsLike)°C")
            print("Weather: \(forecastItem.weather.first?.main ?? "")")
        }
    }
    
    // Run the command-line interface
    func run() async throws {
        print("Welcome to the weather CLI!")
        print("Enter a location to get the current weather and forecast:")
        let location = readLine() ?? ""
        try await displayCurrentWeather(for: location)
        try await displayForecast(for: location)
    }
}

// Run the command-line interface
@main
struct Main {
    static func main() async throws {
        let commandLine = CommandLine()
        try await commandLine.run()
    }
}