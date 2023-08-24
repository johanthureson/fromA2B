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
        app.textFields.firstMatch.typeText("\n")
        sleep(1)
        app.collectionViews.firstMatch.cells.firstMatch.tap()
        
        let textString = app.buttons["from_button"].label
        //  textViews["stop_name"].value
        
        XCTAssertEqual(textString, "från, Logdansplan (Sundbyberg kn)")
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
