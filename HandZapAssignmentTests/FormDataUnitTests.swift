//
//  FormDataUnitTests.swift
//  HandZapAssignmentTests
//
//  Created by Sagar Shinde on 12/01/20.
//  Copyright © 2020 Sagar Shinde. All rights reserved.
//

import XCTest

class FormDataUnitTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInit() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        let form = FormData(formTitle: "title", budget: 20, startDate: formatter.string(from: Date()) )
        XCTAssertNotNil(form)
        XCTAssertNotNil(form.formID)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
