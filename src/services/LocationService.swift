import Foundation
import CoreLocation

class LocationService {
    private let locationManager: CLLocationManager

    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
        self.locationManager.requestWhenInUseAuthorization()
    }

    func getCurrentLocation() async -> (Double, Double)? {
        var currentLocation: (Double, Double)?
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        await withCheckedContinuation { continuation in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                continuation.resume(returning: currentLocation)
            }
        }
        return currentLocation
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            currentLocation = (latitude, longitude)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager failed with error: \(error)")
    }
}