import Foundation
import CommandLineExtensions

class WeatherDisplayController {
    private let currentWeatherController: CurrentWeatherController
    private let locationService: LocationService
    private let unitConverter: UnitConverter

    init(currentWeatherController: CurrentWeatherController, locationService: LocationService, unitConverter: UnitConverter) {
        self.currentWeatherController = currentWeatherController
        self.locationService = locationService
        self.unitConverter = unitConverter
    }

    func displayWeather(for location: String, units: String) async throws {
        let currentWeather = try await currentWeatherController.getWeather(for: location, units: units)
        print(currentWeather)
    }

    func displayCurrentLocationWeather(units: String) async throws {
        guard let currentLocation = await locationService.getCurrentLocation() else {
            throw NSError(domain: "LocationService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Unable to get current location"])
        }
        let location = "\(currentLocation.0),\(currentLocation.1)"
        let currentWeather = try await currentWeatherController.getWeather(for: location, units: units)
        print(currentWeather)
    }
}