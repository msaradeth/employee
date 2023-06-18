//
//  EmployeeViewModelTest.swift
//  EmpDirTests
//
//  Created by Mike Saradeth on 6/17/23.
//

import XCTest
@testable import EmpDir

final class EmployeeViewModelTest: XCTestCase {


    func testFetchData() {
        // Given
        let mockService = MockEmployeeService()
        let viewModel = EmployeeViewModel(service: mockService)
        let expection = XCTestExpectation(description: "Fetch Data")
        var errorMsg: String?
        
        // When
        viewModel.fetchData { errorMessage in
            errorMsg = errorMessage
            expection.fulfill()
        }
        wait(for: [expection], timeout: 1)
        
        // Then
        XCTAssertNil(errorMsg)
        XCTAssertEqual(viewModel.employees.count, 11)
        XCTAssertEqual(viewModel.employees[0].fullname, "Alaina Daly")
    }
}
