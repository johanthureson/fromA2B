//
//  fromA2BTests.swift
//  fromA2BTests
//
//  Created by Johan Thureson on 2023-06-06.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import fromA2B

final class fromA2BTests: XCTestCase {

    func testViewInspectorBaseline() throws {
      let expected = "it lives!"
      let sut = Text(expected)
      let value = try sut.inspect().text().string()
      XCTAssertEqual(value, expected)
    }

}
