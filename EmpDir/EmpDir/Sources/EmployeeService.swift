//
//  EmployeeService.swift
//  EmpDir
//
//  Created by Mike Saradeth on 6/17/23.
//

import Foundation

struct EmpEndponts {
    static let empUrl = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
    static let malformedUrl = "https://s3.amazonaws.com/sq-mobile-interview/employees_malformed.json"
    static let emptyUrl = "https://s3.amazonaws.com/sq-mobile-interview/employees_empty.json"
}


protocol EmployeeServiceType {
    func fetchData<T: Codable>(urlString: String, type: T.Type, completion: @escaping (T?, String?)->Void)
}

final class EmployeeService: EmployeeServiceType {
    func fetchData<T: Codable>(urlString: String, type: T.Type, completion: @escaping (T?, String?)->Void) {
        guard let url = URL(string: urlString) else {
            completion(nil, "Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error.localizedDescription)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                completion(nil, "HTTPURLResponse status code: \(httpStatus.statusCode)")
            }
            
            do {
                let model = try JSONDecoder().decode(type.self, from: data!)
                completion(model, nil)
            } catch let error {
                completion(nil, error.localizedDescription)
            }
            
        }.resume()
    }
}
