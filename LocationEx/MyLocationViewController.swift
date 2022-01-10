
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
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {(granted, error) in}
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager = CLLocationManager();
            self.locationManager?.delegate = self;
            if CLLocationManager.authorizationStatus() != .authorizedAlways {
                self.locationManager?.requestAlwaysAuthorization();
            }
            else {
                self.setupAndStartLocationManager();
            }
            
            geoFenceArray = [geoFenceData(latitude: "22.246660", longitude: "114.175720"),
                            geoFenceData(latitude: "22.284389", longitude: "114.188950")]
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
    
    func renderCircle(_ location: CLLocation){
        let coord = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let circleSpan = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
        let region = MKCoordinateRegion(center: coord, span: circleSpan)
        mapView?.setRegion(region, animated: true)
        mapView?.showsUserLocation = true
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
            
            locationManager?.stopUpdatingLocation()
            renderCircle(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        let phoneAlert = UIAlertController.init(title: "You have now entered the place", message: "entering", preferredStyle: .alert)
        phoneAlert.addAction(UIAlertAction(title: "Got it", style: UIAlertAction.Style.default, handler: nil))
        self.present(phoneAlert, animated: true, completion: nil)
        showNoti(title: "You are entering the actraction", message: "Hope you have a good time")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        let phoneAlert = UIAlertController.init(title: "You have now exited the place", message: "exiting", preferredStyle: .alert)
        phoneAlert.addAction(UIAlertAction(title: "Got it", style: UIAlertAction.Style.default, handler: nil))
        self.present(phoneAlert, animated: true, completion: nil)
        showNoti(title: "You are leaving the actraction", message: "See you again")
    }
    
    func monitorLocation(centerPoint: CLLocationCoordinate2D, identifier: String){
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self){
            let region = CLCircularRegion(center: centerPoint, radius: 150, identifier: identifier)
            region.notifyOnExit = false
            region.notifyOnEntry = true
            let fenceCircle = MKCircle(center: centerPoint, radius: 150)
            mapView?.addOverlay(fenceCircle)
            locationManager?.startMonitoring(for: region)
        }
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
    
    func makePoint(){
        for item in geoFenceArray{
            let coord = CLLocationCoordinate2D(latitude: Double(item.latitude!)!, longitude: Double(item.longitude!)!)
            monitorLocation(centerPoint: coord, identifier: "FencePoint")
        }
    }
    
    
    
}


extension MyLocationViewController : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let circleOverlay = overlay as? MKCircle else {
            return MKOverlayRenderer()
        }
        let circleRender = MKCircleRenderer(circle: circleOverlay)
        circleRender.strokeColor = .red
        circleRender.fillColor = .red
        circleRender.alpha = 0.5
        return circleRender
    }
    
}
