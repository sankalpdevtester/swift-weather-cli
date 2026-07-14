import Foundation
import OpenWeatherMapService

class CurrentWeatherController {
    private let weatherService: OpenWeatherMapService
    private let cache: Cache
    private let weatherFormatter: WeatherFormatter

    init(weatherService: OpenWeatherMapService, cache: Cache, weatherFormatter: WeatherFormatter) {
        self.weatherService = weatherService
        self.cache = cache
        self.weatherFormatter = weatherFormatter
    }

    func getCurrentWeather(for location: String, units: String) async throws -> String {
        let cachedWeather = cache.getWeather(for: location)
        if let cachedWeather = cachedWeather {
            return weatherFormatter.formatCurrentWeather(weather: cachedWeather, units: units)
        }

        let weatherData = try await weatherService.getCurrentWeather(for: location, units: units)
        cache.setWeather(for: location, weather: weatherData)
        return weatherFormatter.formatCurrentWeather(weather: weatherData, units: units)
    }

    func getWeather(for location: String, units: String) async throws -> String {
        do {
            let currentWeather = try await getCurrentWeather(for: location, units: units)
            return currentWeather
        } catch {
            throw error
        }
    }
}