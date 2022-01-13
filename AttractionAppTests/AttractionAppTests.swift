
import MapKit
import XCTest
@testable import AttractionApp

class AttractionAppExTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //this test the data saving function
    func testSaveData() throws {
        let data = AttractionFinderViewController()
        //enter
        let stringEnterMsg = "The User have entered 4 times"
        data.saveEnterData(number: 4)
        XCTAssertEqual(data.saveMsg, stringEnterMsg)
        
        //exit
        let stringExitMsg = "The User have exited 4 times"
        data.saveExitData(number: 4)
        XCTAssertEqual(data.saveMsg, stringExitMsg)
    }
    
    //This test the pin adding function
    func testPins() throws {
        let data = AttractionFinderViewController()
        let testAnnotation = MKPointAnnotation();
        testAnnotation.coordinate = CLLocationCoordinate2D(latitude: 22.384389, longitude: 114.288950);
        testAnnotation.title = "Test Site";
        data.annotations.append(testAnnotation);
        
    }
    
    //this test the geo fences
    func testCircle() throws{
        let data = AttractionFinderViewController()
        let testCoord = CLLocationCoordinate2D(latitude: 22.384389, longitude: 114.288950);
        data.monitorLocation(centerPoint: testCoord, identifier: "FencePoint")
        
    }

}
