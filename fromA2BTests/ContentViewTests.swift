//
//  ContentViewTests.swift
//  fromA2BTests
//
//  Created by Johan Thureson on 2023-08-23.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import fromA2B

final class ContentViewTests: XCTestCase {
    
    func testTabItemTitle() throws {
        let expected = "Trip Search"
        let view = ContentView()
        let tabTitle = try view
          .inspect()
          .find(text: expected)
          .string()
        XCTAssertEqual(tabTitle, expected)
    }
    
}
