

import XCTest

class AttractionAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //this test the app is runable
    func testRuns() throws {
        let app = XCUIApplication()
        app.launch()

    }
    
    //Test for mapkit
    func testMaps() {
        let app = XCUIApplication()
        app.launch()
        //this test the function is accessable
        app/*@START_MENU_TOKEN@*/.staticTexts["Attractions Finder"]/*[[".buttons[\"Attractions Finder\"].staticTexts[\"Attractions Finder\"]",".staticTexts[\"Attractions Finder\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //this test the zooming function of the map
        app.maps.element.pinch(withScale: 0.5, velocity: -5.5)
        app.maps.element.pinch(withScale: 3.5, velocity: 3)
        //this test the back button
        app.navigationBars["Attraction Finder"].buttons["Attraction App"].tap()
        
    }
    
    //Test for table view
    func testAddress(){
        let app = XCUIApplication()
        app.launch()
        
        //this test the function is accessable
        app/*@START_MENU_TOKEN@*/.staticTexts["Attraction View"]/*[[".buttons[\"Attraction View\"].staticTexts[\"Attraction View\"]",".staticTexts[\"Attraction View\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        //swipe up
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["100/F, International Commerce Centre, 1 Austin Road West, Kowloon"]/*[[".cells.staticTexts[\"100\/F, International Commerce Centre, 1 Austin Road West, Kowloon\"]",".staticTexts[\"100\/F, International Commerce Centre, 1 Austin Road West, Kowloon\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        //swipe down
        let attractionAddressNavigationBar = app.navigationBars["Attraction Address"]
        attractionAddressNavigationBar.staticTexts["Attraction Address"].swipeDown()
        //click
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Ocean Park Road, Aberdeen, Hong Kong Island"]/*[[".cells.staticTexts[\"Ocean Park Road, Aberdeen, Hong Kong Island\"]",".staticTexts[\"Ocean Park Road, Aberdeen, Hong Kong Island\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //back button
        attractionAddressNavigationBar.buttons["Attraction App"].tap()
        
        
    }
    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
