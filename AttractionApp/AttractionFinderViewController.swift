import UIKit
import MapKit
import CoreLocation
import FirebaseFirestore


class AttractionFinderViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView : MKMapView?
    
    var locationManager : CLLocationManager?
    var annotations = [MKPointAnnotation]();
    var userEnters : Int = 0
    var userExits : Int = 0
    
    let database = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Attraction Finder"
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {(granted, error) in}
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager = CLLocationManager();
            self.locationManager?.delegate = self;
            self.locationManager?.startUpdatingLocation();
            if CLLocationManager.authorizationStatus() != .authorizedAlways {
                self.locationManager?.requestAlwaysAuthorization();
            }
            else {
                self.setupAndStartLocationManager();
            }
        }
        
        //This is all the attractions pins
        let oPAnnotation = MKPointAnnotation();
        oPAnnotation.coordinate = CLLocationCoordinate2D(latitude: 22.246660, longitude: 114.175720);
        oPAnnotation.title = "Ocean Park";
        self.annotations.append(oPAnnotation);
        
        let disneyAnnotation = MKPointAnnotation();
        disneyAnnotation.coordinate = CLLocationCoordinate2D(latitude: 22.312967, longitude: 114.041282);
        disneyAnnotation.title = "Disneyland";
        self.annotations.append(disneyAnnotation);
        
        let buddhaAnnotation = MKPointAnnotation();
        buddhaAnnotation.coordinate = CLLocationCoordinate2D(latitude: 22.253985, longitude: 113.904984);
        buddhaAnnotation.title = "The Tian Tan Buddha";
        self.annotations.append(buddhaAnnotation);
        
        let templeStreetAnnotation = MKPointAnnotation();
        templeStreetAnnotation.coordinate = CLLocationCoordinate2D(latitude: 22.306518, longitude: 114.169980);
        templeStreetAnnotation.title = "The Temple Street Night Market";
        self.annotations.append(templeStreetAnnotation);
        
        let taiOAnnotation = MKPointAnnotation();
        taiOAnnotation.coordinate = CLLocationCoordinate2D(latitude: 22.2542, longitude: 113.8622);
        taiOAnnotation.title = "Tai O Fishing Village";
        self.annotations.append(taiOAnnotation);
        
        let wongTaiSinAnnotation = MKPointAnnotation();
        wongTaiSinAnnotation.coordinate = CLLocationCoordinate2D(latitude: 22.342572, longitude: 114.193649);
        wongTaiSinAnnotation.title = "The Wong Tai Sin Temple";
        self.annotations.append(wongTaiSinAnnotation);
        
        let skyObvAnnotation = MKPointAnnotation();
        skyObvAnnotation.coordinate = CLLocationCoordinate2D(latitude: 22.303381, longitude: 114.160231);
        skyObvAnnotation.title = "The Sky100 Observation Deck";
        self.annotations.append(skyObvAnnotation);
        
        let manMoAnnotation = MKPointAnnotation();
        manMoAnnotation.coordinate = CLLocationCoordinate2D(latitude: 22.28401, longitude: 114.150291);
        manMoAnnotation.title = "Man Mo Temple";
        self.annotations.append(manMoAnnotation);
        
        let starFerryAnnotation = MKPointAnnotation();
        starFerryAnnotation.coordinate = CLLocationCoordinate2D(latitude: 22.287273, longitude: 114.165904);
        starFerryAnnotation.title = "Star Ferry";
        self.annotations.append(starFerryAnnotation);
        
        let lkfAnnotation = MKPointAnnotation();
        lkfAnnotation.coordinate = CLLocationCoordinate2D(latitude: 22.28107, longitude: 114.155478);
        lkfAnnotation.title = "Lan Kwai Fong";
        self.annotations.append(lkfAnnotation);
        
        let polinAnnotation = MKPointAnnotation();
        polinAnnotation.coordinate = CLLocationCoordinate2D(latitude: 22.255476, longitude: 113.90819);
        polinAnnotation.title = "Po Lin Monastery";
        self.annotations.append(polinAnnotation);
        
        let peakAnnotation = MKPointAnnotation();
        peakAnnotation.coordinate = CLLocationCoordinate2D(latitude: 22.284389, longitude: 114.188950);
        peakAnnotation.title = "The Vitoria Peak";
        self.annotations.append(peakAnnotation);
        
        //this adds the pins to annotations
        self.mapView?.addAnnotations(self.annotations);
        
        //this calls functions to create the geo fence
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
    
    //This updates the circles coords
    func renderCircle(_ location: CLLocation){
        //this sets the circle data for the geo fence
        let coord = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let circleSpan = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
        let region = MKCoordinateRegion(center: coord, span: circleSpan)
        
        mapView?.setRegion(region, animated: true)
        mapView?.showsUserLocation = true
    }
    
    //This updates the coords
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            
//            self.latField?.text = "\(location.coordinate.latitude)";
//            self.lngField?.text = "\(location.coordinate.longitude)";
//            self.accuracyField?.text = "\(location.horizontalAccuracy)";
//
//            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01);
//            let coord = location.coordinate;
//            let region = MKCoordinateRegion(center: coord, span: span)
//            self.mapView?.setRegion(region, animated: false);
            
            locationManager?.startUpdatingLocation()
            renderCircle(location)
        }
    }
    
    //This show the message when user enter
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        userEnters += 1
        
        //this alerts the user
        let phoneAlert = UIAlertController.init(title: "You have now entered the place", message: "entering", preferredStyle: .alert)
        phoneAlert.addAction(UIAlertAction(title: "Got it", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(phoneAlert, animated: true, completion: nil)
        showNoti(title: "You are entering the actraction", message: "Hope you have a good time")
        saveEnterData(number: userEnters)
    }
    
    //This show the message when user leave
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        userExits += 1
        
        //this alerts the user
        let phoneAlert = UIAlertController.init(title: "You have now exited the place", message: "leaving", preferredStyle: .alert)
        phoneAlert.addAction(UIAlertAction(title: "Got it", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(phoneAlert, animated: true, completion: nil)
        showNoti(title: "You are leaving the actraction", message: "See you again")
        saveExitData(number: userExits)
    }
    
    //This monitors the location of each circles in the map
    //And actions will be triggered according to the gps
    func monitorLocation(centerPoint: CLLocationCoordinate2D, identifier: String){
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self){
            //This makes the circle's monitioring range
            let region = CLCircularRegion(center: centerPoint, radius: 150, identifier: identifier)
            //This make the app notifiy user if action is made
            region.notifyOnExit = true
            region.notifyOnEntry = true
            
            locationManager?.startMonitoring(for: region)
            let fenceCircle = MKCircle(center: centerPoint, radius: 150)
            mapView?.addOverlay(fenceCircle)
            
        }
    }
    
    //This save the entry data to firebase
    func saveEnterData(number: Int){
        let ref = database.document("userData/Enter")
        let convert = String(number)
        ref.setData(["Enter Info": "The User have entered " + convert + " times"])
    
    }
    
    //this save the exit data to firebase
    func saveExitData(number: Int){
        let ref = database.document("userData/Exit")
        let convert = String(number)
        ref.setData(["Exit Info": "The User have exited " + convert + " times"])
    
    }
    
    //This set the notification settings
    func showNoti(title: String, message: String){
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        content.badge = 1
        content.sound = .default
        let request = UNNotificationRequest(identifier: "noti", content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    //This create all the circles
    func makePoint(){
        let oCoord = CLLocationCoordinate2D(latitude: 22.246660, longitude: 114.175720);
        let dCoord = CLLocationCoordinate2D(latitude: 22.312967, longitude: 114.041282);
        let bCoord = CLLocationCoordinate2D(latitude: 22.253985, longitude: 113.904984);
        let tCoord = CLLocationCoordinate2D(latitude: 22.306518, longitude: 114.169980);
        let taiOCoord = CLLocationCoordinate2D(latitude: 22.2542, longitude: 113.8622);
        let wCoord = CLLocationCoordinate2D(latitude: 22.342572, longitude: 114.193649);
        let sCoord = CLLocationCoordinate2D(latitude: 22.303381, longitude: 114.160231);
        let mCoord = CLLocationCoordinate2D(latitude: 22.28401, longitude: 114.150291);
        let starCoord = CLLocationCoordinate2D(latitude: 22.287273, longitude: 114.165904);
        let lCoord = CLLocationCoordinate2D(latitude: 22.28107, longitude: 114.155478);
        let polinCoord = CLLocationCoordinate2D(latitude: 22.255476, longitude: 113.90819);
        let pCoord = CLLocationCoordinate2D(latitude: 22.284389, longitude: 114.188950);
        monitorLocation(centerPoint: oCoord, identifier: "FencePoint")
        monitorLocation(centerPoint: dCoord, identifier: "FencePoint")
        monitorLocation(centerPoint: bCoord, identifier: "FencePoint")
        monitorLocation(centerPoint: tCoord, identifier: "FencePoint")
        monitorLocation(centerPoint: taiOCoord, identifier: "FencePoint")
        monitorLocation(centerPoint: wCoord, identifier: "FencePoint")
        monitorLocation(centerPoint: mCoord, identifier: "FencePoint")
        monitorLocation(centerPoint: sCoord, identifier: "FencePoint")
        monitorLocation(centerPoint: starCoord, identifier: "FencePoint")
        monitorLocation(centerPoint: lCoord, identifier: "FencePoint")
        monitorLocation(centerPoint: polinCoord, identifier: "FencePoint")
        monitorLocation(centerPoint: pCoord, identifier: "FencePoint")

    }
}

//This is used to configure the circle display settings of the geo fencing
extension AttractionFinderViewController : MKMapViewDelegate{
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
