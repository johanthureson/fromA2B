//
//  fromA2BUITests.swift
//  fromA2BUITests
//
//  Created by Johan Thureson on 2023-06-06.
//

import XCTest

final class fromA2BUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /*
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    */

    func testSomething()  {
        
        app.buttons["to_button"].tap()
        app.buttons["back_button"].tap()
        app.buttons["from_button"].tap()

        app.textFields.firstMatch.typeText("Logdansplan")
        app.buttons["search_button"].tap()
        app.collectionViews.firstMatch.cells.firstMatch.tap()
        
        let textString = app.buttons["from_button"].label
        //  textViews["stop_name"].value
//        let localizedFrom = String(localized: "stopButtonView.from")
//        let localizedFrom = "stopButtonView.from"

        XCTAssertEqual(textString.dropFirst(4), ", Logdansplan (Sundbyberg kn)")
    }

    /*
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    */
    
    func testUIRecorded() {
        
        
        let app2 = app
        let app = app2
        app.buttons["from_button"].staticTexts["stop_name"].tap()
//        app2/*@START_MENU_TOKEN@*/.keys["A"]/*[[".keyboards.keys[\"A\"]",".keys[\"A\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
//        let lKey = app2/*@START_MENU_TOKEN@*/.keys["l"]/*[[".keyboards.keys[\"l\"]",".keys[\"l\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        lKey.tap()
        app2/*@START_MENU_TOKEN@*/.keys["A"]/*[[".keyboards.keys[\"A\"]",".keys[\"A\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app2.keys["l"].tap()
        app2/*@START_MENU_TOKEN@*/.keys["v"]/*[[".keyboards.keys[\"v\"]",".keys[\"v\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app2/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app2/*@START_MENU_TOKEN@*/.keys["k"]/*[[".keyboards.keys[\"k\"]",".keys[\"k\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
//        let searchButton = app.buttons["Sök"]
//        searchButton.tap()
        app.buttons["search_button"].tap()

        let collectionViewsQuery = app2.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Alvik T-bana (Stockholm kn)"]/*[[".cells.staticTexts[\"Alvik T-bana (Stockholm kn)\"]",".staticTexts[\"Alvik T-bana (Stockholm kn)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app2/*@START_MENU_TOKEN@*/.staticTexts["<>"]/*[[".buttons[\"to, <>\"]",".staticTexts[\"<>\"]",".staticTexts[\"stop_name\"]",".buttons[\"to_button\"]"],[[[-1,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app2/*@START_MENU_TOKEN@*/.keys["C"]/*[[".keyboards.keys[\"C\"]",".keys[\"C\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let eKey = app2/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        eKey.tap()
        
        let nKey = app2/*@START_MENU_TOKEN@*/.keys["n"]/*[[".keyboards.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        nKey.tap()
        app2/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards.keys[\"t\"]",".keys[\"t\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app2/*@START_MENU_TOKEN@*/.keys["r"]/*[[".keyboards.keys[\"r\"]",".keys[\"r\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app2/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app2.keys["l"].tap()
        eKey.tap()
        nKey.tap()
        app.buttons["search_button"].tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["T-Centralen T-bana (Stockholm kn)"]/*[[".cells.staticTexts[\"T-Centralen T-bana (Stockholm kn)\"]",".staticTexts[\"T-Centralen T-bana (Stockholm kn)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app2/*@START_MENU_TOKEN@*/.staticTexts["T-Centralen T-bana (Stockholm kn)"]/*[[".buttons[\"to, T-Centralen T-bana (Stockholm kn)\"]",".staticTexts[\"T-Centralen T-bana (Stockholm kn)\"]",".staticTexts[\"stop_name\"]",".buttons[\"to_button\"]"],[[[-1,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["back_button"]/*[[".buttons[\"Back to Main\"]",".buttons[\"back_button\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            
//        let button1 = app2.staticTexts["T-Centralen T-bana (Stockholm kn)"]
//        let button2 = app2.staticTexts["zzzT-Centralen T-bana (Stockholm kn)"]
        XCTAssert(app.buttons["to_button"].label == "to, T-Centralen T-bana (Stockholm kn)" || app.buttons["to_button"].label == "till, T-Centralen T-bana (Stockholm kn)")
//        XCTAssert(app.buttons["from_button"].staticTexts["stop_name"].label == "T-Centralen T-bana (Stockholm kn)")

//        XCTAssertNotNil(button1)
//        XCTAssertNil(button2)

    }

}
