import Foundation

class UnitConverter {
    enum Unit: String {
        case celsius = "metric"
        case fahrenheit = "imperial"
    }

    func convertTemperature(from temperature: Double, fromUnit: Unit, toUnit: Unit) -> Double {
        switch (fromUnit, toUnit) {
        case (.celsius, .fahrenheit):
            return temperature * 9/5 + 32
        case (.fahrenheit, .celsius):
            return (temperature - 32) * 5/9
        default:
            return temperature
        }
    }

    func getUnitSymbol(for unit: Unit) -> String {
        switch unit {
        case .celsius:
            return "°C"
        case .fahrenheit:
            return "°F"
        }
    }
}