# Swift Weather CLI

A command-line weather application written in Swift that fetches current weather information for any city.

## Features

- 🌡️ Real-time temperature data
- ☁️ Current weather conditions
- 💨 Wind speed and humidity
- 🌍 Support for cities worldwide
- 📊 Clean, formatted output
- ⚙️ Celsius or Fahrenheit units

## Requirements

- Swift 5.5+
- macOS 12+ or Linux with Swift installed

## Installation

1. Clone the repository
2. Build the project:
```bash
swift build -c release
```

3. Run the executable:
```bash
./.build/release/swift-weather
```

## Usage

Basic usage:
```bash
swift run swift-weather London
```

With options:
```bash
swift run swift-weather -c "New York" -u F
swift run swift-weather --city Paris --unit C
```

### Options

- `-c, --city CITY` - City name (required)
- `-u, --unit UNIT` - Temperature unit: C (Celsius) or F (Fahrenheit) [default: C]
- `-h, --help` - Show help message

## API

This CLI uses the WeatherAPI.com service. To use your own API key:

1. Sign up at https://www.weatherapi.com/
2. Replace the `apiKey` variable in `Sources/main.swift`

## Example Output

```
==================================================
🌤️  WEATHER INFORMATION
==================================================

📍 Location:
   London, City of London, Greater London
   United Kingdom
   Local Time: 2025-01-15 14:30

🌡️  Temperature:
   12.0°C
   Feels like: 10.5°C

☁️  Conditions:
   Partly cloudy
   Humidity: 76%
   Wind: 15.8 km/h

==================================================
```

## Development

Run in development mode:
```bash
swift run swift-weather London
```

Run tests:
```bash
swift test
```

## License

MIT License
