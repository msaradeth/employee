//
//  MockEmployeeService.swift
//  EmpDirTests
//
//  Created by Mike Saradeth on 6/17/23.
//

import Foundation
@testable import EmpDir

class MockEmployeeService: EmployeeServiceType {
    func fetchData<T>(urlString: String, type: T.Type, completion: @escaping (T?, String?) -> Void) where T : Decodable, T : Encodable {
        guard let url = Bundle.main.url(forResource: "Employees", withExtension: "json") else {
            completion(nil, "Error creating URL")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let model = try JSONDecoder().decode(T.self, from: data)
            completion(model, nil)
        } catch let error {
            completion(nil, error.localizedDescription)
        }
    }
}
