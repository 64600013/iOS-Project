

import UIKit
import MapKit
import CoreLocation
class MyLocationViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView : MKMapView?
    
    var locationManager : CLLocationManager?
    @IBOutlet weak var latField : UITextField?
    @IBOutlet weak var lngField : UITextField?
    @IBOutlet weak var accuracyField : UITextField?
    override func viewDidLoad() {
        super.viewDidLoad()
            if CLLocationManager.locationServicesEnabled() {
             self.locationManager = CLLocationManager();
             self.locationManager?.delegate = self;
             if CLLocationManager.authorizationStatus() != .authorizedAlways {
             self.locationManager?.requestAlwaysAuthorization();
             }
             else {
             self.setupAndStartLocationManager();
             }
             }
        // Do any additional setup after loading the view.
    }
    //for in-app authorization event
         func locationManager(_ manager: CLLocationManager,
         didChangeAuthorization status: CLAuthorizationStatus) {
         if status == .authorizedAlways {
         self.setupAndStartLocationManager();
         }
         }

        func setupAndStartLocationManager(){
         self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest;
         self.locationManager?.distanceFilter = kCLDistanceFilterNone;
         self.locationManager?.startUpdatingLocation();
         }
    
        func locationManager(_ manager: CLLocationManager,
         didUpdateLocations locations: [CLLocation]) {
         if let location = locations.last {
         self.latField?.text = "\(location.coordinate.latitude)";
         self.lngField?.text = "\(location.coordinate.longitude)";
         self.accuracyField?.text = "\(location.horizontalAccuracy)";

         let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01);
         let coord = location.coordinate;
         let region = MKCoordinateRegion(center: coord, span: span)
         self.mapView?.setRegion(region, animated: false);
         }
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
