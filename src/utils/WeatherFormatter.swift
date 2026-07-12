// src/utils/WeatherFormatter.swift

import Foundation

/// A utility class for formatting weather data into human-readable strings.
class WeatherFormatter {
    /// Formats the given temperature in Kelvin to Celsius or Fahrenheit.
    /// - Parameters:
    ///   - temperature: The temperature in Kelvin.
    ///   - unit: The unit to convert to (Celsius or Fahrenheit).
    /// - Returns: A formatted string representing the temperature.
    static func formatTemperature(_ temperature: Double, unit: String) -> String {
        let formattedTemperature: Double
        switch unit {
        case "Celsius":
            formattedTemperature = temperature - 273.15
        case "Fahrenheit":
            formattedTemperature = (temperature - 273.15) * 9/5 + 32
        default:
            fatalError("Unsupported temperature unit")
        }
        
        return String(format: "%.1f°\(unit)")
    }
    
    /// Formats the given humidity level as a percentage string.
    /// - Parameter humidity: The humidity level (0-100).
    /// - Returns: A formatted string representing the humidity level.
    static func formatHumidity(_ humidity: Int) -> String {
        return "\(humidity)%"
    }
    
    /// Formats the given wind speed in meters per second to kilometers per hour or miles per hour.
    /// - Parameters:
    ///   - windSpeed: The wind speed in meters per second.
    ///   - unit: The unit to convert to (km/h or mph).
    /// - Returns: A formatted string representing the wind speed.
    static func formatWindSpeed(_ windSpeed: Double, unit: String) -> String {
        let formattedWindSpeed: Double
        switch unit {
        case "km/h":
            formattedWindSpeed = windSpeed * 3.6
        case "mph":
            formattedWindSpeed = windSpeed * 2.23694
        default:
            fatalError("Unsupported wind speed unit")
        }
        
        return String(format: "%.1f \(unit)")
    }
    
    /// Formats the given weather condition into a human-readable string.
    /// - Parameter condition: The weather condition (e.g., "Clear", "Cloudy", etc.).
    /// - Returns: A formatted string representing the weather condition.
    static func formatCondition(_ condition: String) -> String {
        return condition.capitalized
    }
    
    /// Formats the given weather data into a human-readable string.
    /// - Parameters:
    ///   - temperature: The temperature in Kelvin.
    ///   - humidity: The humidity level (0-100).
    ///   - windSpeed: The wind speed in meters per second.
    ///   - condition: The weather condition (e.g., "Clear", "Cloudy", etc.).
    ///   - unit: The unit to use for temperature and wind speed (Celsius or Fahrenheit).
    /// - Returns: A formatted string representing the weather data.
    static func formatWeatherData(temperature: Double, humidity: Int, windSpeed: Double, condition: String, unit: String) -> String {
        let formattedTemperature = formatTemperature(temperature, unit: unit)
        let formattedHumidity = formatHumidity(humidity)
        let formattedWindSpeed = formatWindSpeed(windSpeed, unit: unit == "Celsius" ? "km/h" : "mph")
        let formattedCondition = formatCondition(condition)
        
        return """
        Temperature: \(formattedTemperature)
        Humidity: \(formattedHumidity)
        Wind Speed: \(formattedWindSpeed)
        Condition: \(formattedCondition)
        """
    }
}