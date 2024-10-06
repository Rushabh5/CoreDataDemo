//
//  EmployeeTableViewCell.swift
//  MoonPrac
//
//  Created by RS on 25/06/22.
//

import UIKit
import SDWebImage

class EmployeeTableViewCell: UITableViewCell {

    //MARK:
    //MARK: Outlet
    @IBOutlet weak var lblEmpName: UILabel!
    @IBOutlet weak var lblEmpEmail: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    //MARK:
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:
    //MARK: Set Employee Data
    func setEmployeeData(employeeData: EmployeeData) {
        profileImage.sd_setImage(with: URL(string: employeeData.profilePicUrl ?? ""), placeholderImage: UIImage(named: "placeholder"))
        lblEmpName.text = employeeData.fullName
        lblEmpEmail.text = employeeData.email
        lblDate.text = employeeData.createdAt
    }
}
