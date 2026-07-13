import Foundation

class OpenWeatherMapService {
    let apiKey: String
    let baseUrl: String
    
    init(apiKey: String, baseUrl: String = "https://api.openweathermap.org/data/2.5") {
        self.apiKey = apiKey
        self.baseUrl = baseUrl
    }
    
    func getCurrentWeather(for location: String, completion: @escaping (Result<CurrentWeather, Error>) -> Void) {
        let url = URL(string: "\(baseUrl)/weather?q=\(location)&appid=\(apiKey)")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Invalid data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let currentWeather = try JSONDecoder().decode(CurrentWeather.self, from: data)
                completion(.success(currentWeather))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getForecastWeather(for location: String, completion: @escaping (Result<[ForecastWeather], Error>) -> Void) {
        let url = URL(string: "\(baseUrl)/forecast?q=\(location)&appid=\(apiKey)")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Invalid data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let forecastWeather = try JSONDecoder().decode([ForecastWeather].self, from: data)
                completion(.success(forecastWeather))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}