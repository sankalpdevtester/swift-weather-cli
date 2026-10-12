import Foundation

// MARK: - Models
struct WeatherResponse: Codable {
    let location: Location
    let current: CurrentWeather
    
    struct Location: Codable {
        let name: String
        let region: String
        let country: String
        let localtime: String
    }
    
    struct CurrentWeather: Codable {
        let temp_c: Double
        let temp_f: Double
        let condition: Condition
        let humidity: Int
        let wind_kph: Double
        let feelslike_c: Double
        let feelslike_f: Double
        
        struct Condition: Codable {
            let text: String
        }
    }
}

// MARK: - Weather CLI
class WeatherCLI {
    let apiKey = "demo" // Replace with actual API key
    
    func fetchWeather(city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let urlString = "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(city)&aqi=no"
        
        guard let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(encodedCity)&aqi=no") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherResponse.self, from: data)
                completion(.success(weatherData))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func displayWeather(_ weather: WeatherResponse, unit: String = "C") {
        print("\n" + String(repeating: "=", count: 50))
        print("🌤️  WEATHER INFORMATION")
        print(String(repeating: "=", count: 50))
        
        print("\n📍 Location:")
        print("   \(weather.location.name), \(weather.location.region)")
        print("   \(weather.location.country)")
        print("   Local Time: \(weather.location.localtime)")
        
        print("\n🌡️  Temperature:")
        if unit.uppercased() == "C" {
            print("   \(weather.current.temp_c)°C")
            print("   Feels like: \(weather.current.feelslike_c)°C")
        } else {
            print("   \(weather.current.temp_f)°F")
            print("   Feels like: \(weather.current.feelslike_f)°F")
        }
        
        print("\n☁️  Conditions:")
        print("   \(weather.current.condition.text)")
        print("   Humidity: \(weather.current.humidity)%")
        print("   Wind: \(weather.current.wind_kph) km/h")
        
        print("\n" + String(repeating: "=", count: 50) + "\n")
    }
    
    func run() {
        print("\n🌦️  Swift Weather CLI\n")
        
        let arguments = CommandLine.arguments
        
        if arguments.count < 2 {
            printUsage()
            return
        }
        
        var city = ""
        var unit = "C"
        
        var i = 1
        while i < arguments.count {
            let arg = arguments[i]
            
            switch arg {
            case "-c", "--city":
                if i + 1 < arguments.count {
                    city = arguments[i + 1]
                    i += 1
                }
            case "-u", "--unit":
                if i + 1 < arguments.count {
                    unit = arguments[i + 1]
                    i += 1
                }
            case "-h", "--help":
                printUsage()
                return
            default:
                if city.isEmpty {
                    city = arg
                }
            }
            i += 1
        }
        
        if city.isEmpty {
            print("❌ Error: City name required")
            printUsage()
            return
        }
        
        let semaphore = DispatchSemaphore(value: 0)
        
        print("Fetching weather for \(city)...\n")
        
        fetchWeather(city: city) { [weak self] result in
            switch result {
            case .success(let weather):
                self?.displayWeather(weather, unit: unit)
            case .failure(let error):
                print("❌ Error: \(error.localizedDescription)")
            }
            semaphore.signal()
        }
        
        semaphore.wait()
    }
    
    func printUsage() {
        print("""
        Usage: swift-weather [OPTIONS] CITY
        
        Get current weather information for a city.
        
        Options:
          -c, --city CITY     City name (required)
          -u, --unit UNIT     Temperature unit: C (Celsius) or F (Fahrenheit) [default: C]
          -h, --help          Show this help message
        
        Examples:
          swift-weather London
          swift-weather -c "New York" -u F
          swift-weather --city Paris --unit C
        """)
    }
}

// MARK: - Entry Point
let cli = WeatherCLI()
cli.run()
