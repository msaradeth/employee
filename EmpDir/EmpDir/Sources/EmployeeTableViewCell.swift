//
//  EmployeeTableViewCell.swift
//  EmpDir
//
//  Created by Mike Saradeth on 6/17/23.
//

import UIKit
import Kingfisher

class EmployeeTableViewCell: UITableViewCell {
    @IBOutlet weak var empImageView: UIImageView!
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var team: UILabel!

    func configure(emp: Employee){
        self.fullname.text = emp.fullname
        self.team.text = emp.team
        if let urlString = emp.photoUrlSmall, let url = URL(string: urlString) {
            empImageView.kf.setImage(with: url, placeholder:UIImage(systemName: "person.circle"))
        } else {
            // set default image in case the cell is reused.
            empImageView.image = UIImage(systemName: "person.circle")
        }
    }
}

extension UITableViewCell {
    static var reuseID: String {
        return "\(self)"
    }
}
