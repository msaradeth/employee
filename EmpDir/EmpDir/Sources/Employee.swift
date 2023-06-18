//
//  Employee.swift
//  EmpDir
//
//  Created by Mike Saradeth on 6/17/23.
//

import Foundation

struct EmployeeContainer: Codable {
    let employees: [Employee]
}

struct Employee: Codable {
    let uuid: String
    let fullname: String
    let phone: String?
    let email: String
    let biography: String?
    let photoUrlSmall: String?
    let photoUrlLarge: String?
    let team: String
    let employeeType: String
    
    enum CodingKeys: String, CodingKey {
        case uuid = "uuid"
        case fullname = "full_name"
        case phone = "phone_number"
        case email = "email_address"
        case biography = "biography"
        case photoUrlSmall = "photo_url_small"
        case photoUrlLarge = "photo_url_large"
        case team = "team"
        case employeeType = "employee_type"
    }
}
