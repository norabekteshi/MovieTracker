//
//  CinemasMapViewController.swift
//  MovieTracker
//
//  PHASE 2 — REQ 9 (MKMapView + annotations), REQ 10 (user location),
//            REQ 11 (drawing a route between two points), REQ 8 (code constraints).
//
//  How to use: the map shows cinemas around Pristina. Tap any cinema pin
//  and a driving route is drawn to it from your location.
//

import UIKit
import MapKit
import CoreLocation

final class CinemasMapViewController: UIViewController {

    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    private var hasCentered = false

    // Fallback start point (Pristina centre) so a route ALWAYS draws,
    // even if the simulator has no simulated location set.
    private let cityCenter = CLLocationCoordinate2D(latitude: 42.6629,
                                                    longitude: 21.1655)

    private struct Cinema {
        let name: String
        let coordinate: CLLocationCoordinate2D
    }

    // REQ 9: the cinemas placed as annotations on the map.
    private let cinemas: [Cinema] = [
        Cinema(name: "Cineplexx Prishtina",
               coordinate: CLLocationCoordinate2D(latitude: 42.6283, longitude: 21.1480)),
        Cinema(name: "Kino ABC",
               coordinate: CLLocationCoordinate2D(latitude: 42.6612, longitude: 21.1622)),
        Cinema(name: "Cinema City",
               coordinate: CLLocationCoordinate2D(latitude: 42.6705, longitude: 21.1748)),
        Cinema(name: "Kino Armata",
               coordinate: CLLocationCoordinate2D(latitude: 42.6647, longitude: 21.1601))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cinemas Near Me"
        view.backgroundColor = .systemBackground
        setupMap()
        addCinemaAnnotations()
        setupLocation()
    }

    private func setupMap() {
        mapView.delegate = self
        mapView.showsUserLocation = true           // REQ 10
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)

        // REQ 8: constraints in code.
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let region = MKCoordinateRegion(
            center: cityCenter,
            span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08))
        mapView.setRegion(region, animated: false)
    }

    // REQ 9: place an annotation (pin) for every cinema.
    private func addCinemaAnnotations() {
        for cinema in cinemas {
            let pin = MKPointAnnotation()
            pin.title = cinema.name
            pin.subtitle = "Tap the pin to draw the route"
            pin.coordinate = cinema.coordinate
            mapView.addAnnotation(pin)
        }
    }

    // REQ 10: ask permission, then start receiving the user's location.
    private func setupLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

    // REQ 11: calculate and draw a route between two points.
    private func drawRoute(to destination: CLLocationCoordinate2D) {
        let start = mapView.userLocation.location?.coordinate ?? cityCenter

        mapView.removeOverlays(mapView.overlays)

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: start))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        request.transportType = .automobile

        MKDirections(request: request).calculate { [weak self] response, _ in
            guard let self else { return }
            guard let route = response?.routes.first else { return }
            self.mapView.addOverlay(route.polyline)
            self.mapView.setVisibleMapRect(
                route.polyline.boundingMapRect,
                edgePadding: UIEdgeInsets(top: 70, left: 50, bottom: 70, right: 50),
                animated: true)
        }
    }
}

// MARK: - MKMapViewDelegate

extension CinemasMapViewController: MKMapViewDelegate {

    // REQ 11: draw the route line on the map.
    func mapView(_ mapView: MKMapView,
                 rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .systemBlue
            renderer.lineWidth = 5
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }

    // Tapping a cinema pin draws a route to it.
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation,
              !(annotation is MKUserLocation) else { return }
        drawRoute(to: annotation.coordinate)
    }
}

// MARK: - CLLocationManagerDelegate (REQ 10)

extension CinemasMapViewController: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard !hasCentered, let location = locations.last else { return }
        hasCentered = true
        let region = MKCoordinateRegion(
            center: location.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.06, longitudeDelta: 0.06))
        mapView.setRegion(region, animated: true)
    }
}
