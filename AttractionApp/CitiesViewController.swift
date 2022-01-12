

import UIKit
import MapKit
import CoreLocation

class CitiesViewController: UIViewController,UITableViewDataSource {
//    @IBOutlet weak var mapView : MKMapView?
//    var annotations = [MKPointAnnotation]();
    let attractionArray: [[String]] = [["Ocean Park", "The Peak", "The Sky100", "Disneyland", "Lan Kwai Fong"], ["The Buddha", "The Wong Tai Sin Temple", "Man Mo Temple", "Po Lin Monastery"], ["Star Ferry", "Tai O Fishing Village", "Temple Street Night Market"]]
    let headers: [String] = ["Modern Attractions", "Traditional Temples", "Old Hong Kong Sites"]
    let picsArray: [[UIImage]] = [[#imageLiteral(resourceName: "oceanpark"), #imageLiteral(resourceName: "peak"), #imageLiteral(resourceName: "sky100"), #imageLiteral(resourceName: "disneyland"), #imageLiteral(resourceName: "lkf")],[#imageLiteral(resourceName: "buddha"), #imageLiteral(resourceName: "wts"), #imageLiteral(resourceName: "manwo"), #imageLiteral(resourceName: "polin")],[#imageLiteral(resourceName: "starferry"), #imageLiteral(resourceName: "taio"), #imageLiteral(resourceName: "templestreet")]]
    let details: [[String]] = [["Ocean Park Road, Aberdeen, Hong Kong Island", "128 Peak Road, Mid-Levels, Hong Kong Island", "100/F, International Commerce Centre, 1 Austin Road West, Kowloon", "Sunny Bay, Lantau Island", "1 Lan Kwai Fong, Central"], ["Ngong Ping Rd, Lantau Island", "Sik Sik Yuen Wong Tai Sin Temple, 2, Chuk Yuen Village, Wong Tai Sin, Kowloon, Hong Kong", "Man Mo Temple, Hollywood Rd, Sheung Wan", "Po Lin Monastery, Ngong Ping, Lantau Island"], ["Star Ferry Pier, Tsim Sha Tsui, Central or Wan Chai", "Tai O, Lantau Island", "Temple St, Jordan, Kowloon"]]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return attractionArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attractionArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let displayCell = tableView.dequeueReusableCell(withIdentifier: "displayCell", for: indexPath)
        displayCell.textLabel?.text = attractionArray[indexPath.section][indexPath.row]
        displayCell.imageView?.image = picsArray[indexPath.section][indexPath.row]
        displayCell.detailTextLabel?.text = details[indexPath.section][indexPath.row]
        return displayCell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Attraction Address"
//        let nycAnnotation = MKPointAnnotation();
//        nycAnnotation.coordinate = CLLocationCoordinate2D(latitude: 40.71, longitude: -74.0);
//         nycAnnotation.title = "New York City";
//         self.annotations.append(nycAnnotation);
//
//        let hkAnnotation = MKPointAnnotation();
//        hkAnnotation.coordinate = CLLocationCoordinate2D(latitude: 22.3, longitude: 114.17);
//        hkAnnotation.title = "Hong Kong";
//         self.annotations.append(hkAnnotation);
//
//        let tehranAnnotation = MKPointAnnotation();
//        tehranAnnotation.coordinate = CLLocationCoordinate2D(latitude: 35.69, longitude: 51.39);
//        tehranAnnotation.title = "Tehran";
//         self.annotations.append(tehranAnnotation);
//
//        let sydneyAnnotation = MKPointAnnotation();
//        sydneyAnnotation.coordinate = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.21);
//        sydneyAnnotation.title = "Sydney";
//         self.annotations.append(sydneyAnnotation);
//
//        self.mapView?.addAnnotations(self.annotations);
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
