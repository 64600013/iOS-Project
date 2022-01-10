
import UIKit
import MapKit
import CoreLocation

struct geoFenceData {
    var latitude : String?
    var longitude : String?
}

class MyLocationViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView : MKMapView?
    
    var locationManager : CLLocationManager?
    @IBOutlet weak var latField : UITextField?
    @IBOutlet weak var lngField : UITextField?
    @IBOutlet weak var accuracyField : UITextField?
    var annotations = [MKPointAnnotation]();
    var geoFenceArray = [geoFenceData]()
    
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
            
            geoFenceArray = [geoFenceData(latitude: "22.246660", longitude: "114.175720")]
        }
        let oPAnnotation = MKPointAnnotation();
        oPAnnotation.coordinate = CLLocationCoordinate2D(latitude: 22.246660, longitude: 114.175720);
        oPAnnotation.title = "Ocean Park";
        self.annotations.append(oPAnnotation);
        
        let peakAnnotation = MKPointAnnotation();
        peakAnnotation.coordinate = CLLocationCoordinate2D(latitude: 22.284389, longitude: 114.188950);
        peakAnnotation.title = "The Vitoria Peak";
        self.annotations.append(peakAnnotation);
        
        self.mapView?.addAnnotations(self.annotations);
        makePoint()
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
    
    @IBAction func addSpot(_ sender: Any) {
        print("test")
        
        guard let pressing = sender as? UILongPressGestureRecognizer else
            { return }
        let touchLocation = pressing.location(in: mapView)
        let coord = mapView?.convert(touchLocation, toCoordinateFrom: mapView)
        
        let region = CLCircularRegion(center: coord!, radius: 100, identifier: "fence")
        
        
        locationManager?.startMonitoring(for: region)
        let circle = MKCircle(center: coord!, radius: region.radius)
        mapView?.addOverlay(circle)
    }
    
    func showNoti(title: String, message: String){
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        content.badge = 1
        content.sound = .default
        let request = UNNotificationRequest(identifier: "noti", content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func monitorLocation(centerPoint: CLLocationCoordinate2D, identifier: String){
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self){
            let region = CLCircularRegion(center: centerPoint, radius: 100, identifier: identifier)
            region.notifyOnExit = false
            region.notifyOnEntry = true
            let fenceCircle = MKCircle(center: centerPoint, radius: 100)
            mapView?.addOverlay(fenceCircle)
            locationManager?.startMonitoring(for: region)
        }
    }
    
    func makePoint(){
        for item in geoFenceArray{
            let coord = CLLocationCoordinate2D(latitude: Double(item.latitude!)!, longitude: Double(item.longitude!)!)
            monitorLocation(centerPoint: coord, identifier: "FencePoint")
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
