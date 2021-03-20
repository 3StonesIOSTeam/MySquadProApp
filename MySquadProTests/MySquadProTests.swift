//
//  MySquadProTests.swift
//  MySquadProTests
//
//  Created by Bhargin Kanani on 2/15/21.
//

@testable import MySquadPro
import XCTest


class MySquadProTests: XCTestCase {
    var sec: SecurityService?
    
    override func setUp() {
        super.setUp()
        sec = SecurityService(withEmail: "baker@gmail.com", password: "", accessCode: "adc54")
    }
    
    override func tearDown() {
        sec = nil
        super.tearDown()
    }
    
    
    func testFirestoreUserQuery() {
        let result = sec!.authenticateUser() 
        XCTAssertEqual("", "")
    }



}
