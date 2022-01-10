

import UIKit
import MapKit
import CoreLocation

class CitiesViewController: UIViewController {
    @IBOutlet weak var mapView : MKMapView?
    var annotations = [MKPointAnnotation]();
    override func viewDidLoad() {
        super.viewDidLoad()
        let nycAnnotation = MKPointAnnotation();
        nycAnnotation.coordinate = CLLocationCoordinate2D(latitude: 40.71, longitude: -74.0);
         nycAnnotation.title = "New York City";
         self.annotations.append(nycAnnotation);
        
        let hkAnnotation = MKPointAnnotation();
        hkAnnotation.coordinate = CLLocationCoordinate2D(latitude: 22.3, longitude: 114.17);
        hkAnnotation.title = "Hong Kong";
         self.annotations.append(hkAnnotation);
        
        let tehranAnnotation = MKPointAnnotation();
        tehranAnnotation.coordinate = CLLocationCoordinate2D(latitude: 35.69, longitude: 51.39);
        tehranAnnotation.title = "Tehran";
         self.annotations.append(tehranAnnotation);
        
        let sydneyAnnotation = MKPointAnnotation();
        sydneyAnnotation.coordinate = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.21);
        sydneyAnnotation.title = "Sydney";
         self.annotations.append(sydneyAnnotation);
        
        self.mapView?.addAnnotations(self.annotations);
        // Do any additional setup after loading the view.
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
