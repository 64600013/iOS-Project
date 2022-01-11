
import UIKit
import MapKit
import CoreLocation

class MySchoolViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let overlayCoords = [
         CLLocationCoordinate2D(latitude: 22.391205, longitude: 114.197092),
         CLLocationCoordinate2D(latitude: 22.391686, longitude: 114.198229),
         CLLocationCoordinate2D(latitude: 22.389583, longitude: 114.199039),
         CLLocationCoordinate2D(latitude: 22.389251, longitude: 114.19824)
         ]
         let overlay = MKPolygon(coordinates: overlayCoords, count: 4);
         let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005);
         let coord = CLLocationCoordinate2D(latitude: 22.390208, longitude: 114.198133);
         let region = MKCoordinateRegion(center: coord, span: span)
         self.mapView?.delegate = self;
         self.mapView?.setRegion(region, animated: false);
         self.mapView?.addOverlay(overlay);
        // Do any additional setup after loading the view.
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay)
     -> MKOverlayRenderer {
     let polygonRenderer = MKPolygonRenderer(overlay: overlay);
     polygonRenderer.strokeColor = UIColor.clear;
     polygonRenderer.fillColor = UIColor.blue;
     polygonRenderer.alpha = 0.5;
     return polygonRenderer;
     }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
