# Swift Weather CLI
[![Swift](https://img.shields.io/badge/Swift-5.7-orange.svg)](https://swift.org/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## What it does
The Swift Weather CLI is a command-line tool for retrieving and displaying current weather conditions. It utilizes the OpenWeatherMap API to provide users with accurate and up-to-date weather information. This tool is designed for individuals who want to quickly check the weather from their terminal.

## Features
* Current weather display
* 5-day forecast
* Location-based weather
* Unit conversion (Celsius/Fahrenheit)
* Error handling for API requests

## Requirements
* Swift 5.7
* Swift Package Manager (SPM) 5.7
* OpenWeatherMap API key

## Installation
To install the Swift Weather CLI, navigate to the project directory and run the following command:
```bash
swift package resolve
```
This will resolve the dependencies required by the project.

## Usage
To run the Swift Weather CLI, use the following command:
```bash
swift run
```
You can also specify the location and units using the following commands:
```bash
swift run --location London
swift run --units celsius
```
Expected output:
```
Current weather in London:
Temperature: 22°C
Conditions: Sunny
Humidity: 60%
Wind Speed: 10 km/h

5-day forecast:
Day 1: Sunny, 22°C
Day 2: Cloudy, 20°C
Day 3: Rainy, 18°C
Day 4: Sunny, 22°C
Day 5: Cloudy, 20°C
```

## Environment Variables
| Variable | Description |
| --- | --- |
| OPENWEATHERMAP_API_KEY | Your OpenWeatherMap API key |
| LOCATION | The location for which to retrieve the weather (default: current location) |
| UNITS | The units to use for temperature (celsius or fahrenheit, default: celsius) |

## Project Structure
```
SwiftWeatherCLI
├── Package.swift
├── Sources
│   ├── main.swift
│   ├── WeatherAPI.swift
│   ├── LocationManager.swift
│   └── UnitConverter.swift
├── Tests
│   ├── WeatherAPITests.swift
│   ├── LocationManagerTests.swift
│   └── UnitConverterTests.swift
└── README.md
```

## Contributing
To contribute to the Swift Weather CLI, please fork the repository and submit a pull request. Make sure to include tests for any new features or bug fixes.

## License
The Swift Weather CLI is licensed under the MIT License. See [LICENSE](LICENSE) for details.