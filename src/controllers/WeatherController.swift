import Foundation

class WeatherController {
    let openWeatherMapService: OpenWeatherMapService
    let weatherFormatter: WeatherFormatter
    
    init(openWeatherMapService: OpenWeatherMapService, weatherFormatter: WeatherFormatter) {
        self.openWeatherMapService = openWeatherMapService
        self.weatherFormatter = weatherFormatter
    }
    
    func getCurrentWeather(for location: String, completion: @escaping (Result<String, Error>) -> Void) {
        openWeatherMapService.getCurrentWeather(for: location) { result in
            switch result {
            case .success(let currentWeather):
                let formattedWeather = weatherFormatter.formatCurrentWeather(currentWeather)
                completion(.success(formattedWeather))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getForecastWeather(for location: String, completion: @escaping (Result<String, Error>) -> Void) {
        openWeatherMapService.getForecastWeather(for: location) { result in
            switch result {
            case .success(let forecastWeather):
                let formattedWeather = weatherFormatter.formatForecastWeather(forecastWeather)
                completion(.success(formattedWeather))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}