//
//  EmployeeViewModel.swift
//  EmpDir
//
//  Created by Mike Saradeth on 6/17/23.
//

import Foundation

protocol EmployeeViewModelType {
    var employees: [Employee] { get }
    func fetchData(completion: @escaping (String?)->())
}

final class EmployeeViewModel: EmployeeViewModelType {
    var employees: [Employee]
    var service: EmployeeServiceType
    var urlString = EmpEndponts.empUrl
    
    init(employee: [Employee] = [], service: EmployeeServiceType) {
        self.employees = employee
        self.service = service
    }
    
    func fetchData(completion: @escaping (String?)->()) {
        service.fetchData(urlString: urlString, type: EmployeeContainer.self) { [weak self] (container, errorMsg) in
            if let errorMsg = errorMsg {
                self?.employees = []
                completion(errorMsg)
                return
            }
            
            guard let employees = container?.employees, employees.count > 0 else {
                self?.employees = []
                completion("0 employees found.")
                return
            }
            
            self?.employees = employees.sorted { $0.fullname < $1.fullname }
            completion(nil)
        }
    }
}
