
import UIKit

class AttractionAddressFinder: UIViewController,UITableViewDataSource {
    //this stores the attraction name
    let attractionArray: [[String]] = [["Ocean Park", "The Peak", "The Sky100", "Disneyland", "Lan Kwai Fong"], ["The Buddha", "The Wong Tai Sin Temple", "Man Mo Temple", "Po Lin Monastery"], ["Star Ferry", "Tai O Fishing Village", "Temple Street Night Market"]]
    //this categrise the attractions
    let headers: [String] = ["Modern Attractions", "Traditional Temples", "Old Hong Kong Sites"]
    //this is the profile pics
    let picsArray: [[UIImage]] = [[#imageLiteral(resourceName: "oceanpark"), #imageLiteral(resourceName: "peak"), #imageLiteral(resourceName: "sky100"), #imageLiteral(resourceName: "disneyland"), #imageLiteral(resourceName: "lkf")],[#imageLiteral(resourceName: "buddha"), #imageLiteral(resourceName: "wts"), #imageLiteral(resourceName: "manwo"), #imageLiteral(resourceName: "polin")],[#imageLiteral(resourceName: "starferry"), #imageLiteral(resourceName: "taio"), #imageLiteral(resourceName: "templestreet")]]
    //this stores the address
    let details: [[String]] = [["Ocean Park Road, Aberdeen, Hong Kong Island", "128 Peak Road, Mid-Levels, Hong Kong Island", "100/F, International Commerce Centre, 1 Austin Road West, Kowloon", "Sunny Bay, Lantau Island", "1 Lan Kwai Fong, Central"], ["Ngong Ping Rd, Lantau Island", "Sik Sik Yuen Wong Tai Sin Temple, 2, Chuk Yuen Village, Wong Tai Sin, Kowloon, Hong Kong", "Man Mo Temple, Hollywood Rd, Sheung Wan", "Po Lin Monastery, Ngong Ping, Lantau Island"], ["Star Ferry Pier, Tsim Sha Tsui, Central or Wan Chai", "Tai O, Lantau Island", "Temple St, Jordan, Kowloon"]]
    
    //this print the cells
    func numberOfSections(in tableView: UITableView) -> Int {
        return attractionArray.count
    }
    
    //this print the headers of cells
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    
    //this section different cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attractionArray[section].count
    }
    
    //this display all the text and pics inside the cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //init cells
        let displayCell = tableView.dequeueReusableCell(withIdentifier: "displayCell", for: indexPath)
        //main text
        displayCell.textLabel?.text = attractionArray[indexPath.section][indexPath.row]
        //image
        displayCell.imageView?.image = picsArray[indexPath.section][indexPath.row]
        //subtitles
        displayCell.detailTextLabel?.text = details[indexPath.section][indexPath.row]
        return displayCell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Attraction Address"

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
