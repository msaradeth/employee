//
//  EmployeeServiceTest.swift
//  EmpDirTests
//
//  Created by Mike Saradeth on 6/17/23.
//

import XCTest
@testable import EmpDir

final class EmployeeServiceTest: XCTestCase {

    func testFetchDataWithVaidURL() {
        // Given
        let expection = XCTestExpectation(description: "Fetch Data")
        let service = EmployeeService()
        var errorMsg: String?
        var container: EmployeeContainer?
        
        // When
        let urlString = EmpEndponts.empUrl
        service.fetchData(urlString: urlString, type: EmployeeContainer.self) { (empContainer, errorMessage) in
            errorMsg = errorMessage
            container = empContainer
            expection.fulfill()
        }
        wait(for: [expection], timeout: 5)
        
        // Then
        XCTAssertNil(errorMsg)
        XCTAssertEqual(container?.employees.count, 11)
    }
    
    func testFetchDataWithEmptyURL() {
        // Given
        let expection = XCTestExpectation(description: "Fetch Data")
        let service = EmployeeService()
        var errorMsg: String?
        var container: EmployeeContainer?
        
        // When
        let urlString = EmpEndponts.emptyUrl
        service.fetchData(urlString: urlString, type: EmployeeContainer.self) { (empContainer, errorMessage) in
            errorMsg = errorMessage
            container = empContainer
            expection.fulfill()
        }
        wait(for: [expection], timeout: 5)
        
        // Then
        XCTAssertNil(errorMsg)
        XCTAssertEqual(container?.employees.count, 0)
    }
    
    func testFetchDataWithMalformedURL() {
        // Given
        let expection = XCTestExpectation(description: "Fetch Data")
        let service = EmployeeService()
        var errorMsg: String?
        var container: EmployeeContainer?
        
        // When
        let urlString = EmpEndponts.malformedUrl
        service.fetchData(urlString: urlString, type: EmployeeContainer.self) { (empContainer, errorMessage) in
            errorMsg = errorMessage
            container = empContainer
            expection.fulfill()
        }
        wait(for: [expection], timeout: 5)
        
        // Then
        XCTAssertNil(container)
        XCTAssertEqual(errorMsg, "The data couldn’t be read because it is missing.")
    }
}
