import MapKit
import UIKit

final class MapViewController: UIViewController {
    private let mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Nearest Theaters"
        view.backgroundColor = .systemBackground
        configureMap()
    }

    private func configureMap() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let center = CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
        mapView.setRegion(region, animated: false)

        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "Nearest Theater"
        mapView.addAnnotation(annotation)
    }
}
