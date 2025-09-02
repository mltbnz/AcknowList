//
//  AcknowPackageParserTests.swift
//  AcknowExampleTests
//
//  Created by Vincent Tourraine on 15/08/15.
//  Copyright © 2015-2025 Vincent Tourraine. All rights reserved.
//

import XCTest

@testable import AcknowList

class AcknowPackageParserTests: XCTestCase {

    func testParsePackageVersion1() throws {
        let bundle = resourcesBundle()
        let url = try XCTUnwrap(bundle.url(forResource: "Package-version-1", withExtension: "resolved"))
        let data = try Data(contentsOf: url)

        let decoder = AcknowPackageDecoder()
        let acknowList = try decoder.decode(from: data)
        XCTAssertNil(acknowList.headerText)
        XCTAssertNil(acknowList.footerText)
        XCTAssertEqual(acknowList.acknowledgements.count, 6)

        let first = try XCTUnwrap(acknowList.acknowledgements.first)
        XCTAssertEqual(first.title, "AcknowList")
        XCTAssertEqual(first.repository, URL(string: "https://github.com/vtourraine/AcknowList.git"))
        XCTAssertNil(first.text)
        XCTAssertNil(first.license)
        // New: verify version and revision parsed from v1 state
        XCTAssertEqual(first.version, "2.1.0")
        XCTAssertEqual(first.revision, "e66b9541c1902ced4979b3c214a5def2cf96f015")
    }

    func testParsePackageVersion2() throws {
        let bundle = resourcesBundle()
        let url = try XCTUnwrap(bundle.url(forResource: "Package-version-2", withExtension: "resolved"))
        let data = try Data(contentsOf: url)
        
        let decoder = AcknowPackageDecoder()
        let acknowList = try decoder.decode(from: data)
        XCTAssertEqual(acknowList.acknowledgements.count, 1)

        let first = try XCTUnwrap(acknowList.acknowledgements.first)
        XCTAssertEqual(first.title, "thirdpartymailer")
        XCTAssertEqual(first.repository, URL(string: "https://github.com/vtourraine/ThirdPartyMailer.git"))
        XCTAssertNil(first.text)
        XCTAssertNil(first.license)
        // New: verify version and revision parsed from v2 state
        XCTAssertEqual(first.version, "2.1.0")
        XCTAssertEqual(first.revision, "44c1cfaa6969963f22691aa67f88a69e3b6d651f")
    }
}
