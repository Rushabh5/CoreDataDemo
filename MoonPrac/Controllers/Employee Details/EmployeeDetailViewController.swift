//
//  EmployeeDetailViewController.swift
//  MoonPrac
//
//  Created by RS on 25/06/22.
//

import UIKit

class EmployeeDetailViewController: UIViewController {
    
    //MARK:
    //MARK: Property
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var employeeModel: EmployeeData?
    private var employeeDetailsVM = EmployeeDetailViewModel()
    var isFromDetails = false
    private var arrayOfCells: [LabelWithTextfieldTableViewCell] = []
    private var fullname: String?, email: String?, phoneNuber: String?, address: String?, birthDate: String?, gender: String?, desigation: String?
    private var salary: Int?
    
    //MARK:
    //MARK: UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.btnSave.isHidden = isFromDetails
        tableView.backgroundView = UIView()
        tableView.register(UINib(nibName: "LabelWithTextfieldTableViewCell", bundle: nil), forCellReuseIdentifier: "LabelWithTextfieldTableViewCell")
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
       view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK:
    //MARK: UIButton Action Method
    @IBAction func didTapSave(_ sender: UIButton) {
        for index in 0...7 {
            if let cell = tableView.cellForRow(at: IndexPath(item: index, section: 0)) as? LabelWithTextfieldTableViewCell {
                switch (index) {
                case 0:
                    fullname = cell.textfield.text!
                case 1:
                    email = cell.textfield.text!
                case 2:
                    phoneNuber = cell.textfield.text!
                case 3:
                    address = cell.textfield.text!
                case 4:
                    birthDate = cell.textfield.text!
                case 5:
                    gender = cell.textfield.text!
                case 6:
                    desigation = cell.textfield.text!
                case 7:
                    salary = Int(cell.textfield.text!)
                default:
                    break
                }
            }
        }
        if validateEmployee() {
            let param = ["full_name": fullname ?? "", "email": email ?? "", "phone": phoneNuber ?? "", "address": address ?? "", "dob": birthDate ?? "", "gender": gender?.lowercased() ?? "", "designation": desigation ?? "", "salary": salary ?? 0] as [String : Any]
            employeeDetailsVM.saveEmployeeData(param: param) { status, message in
                if status! {
                    self.showAlertwithOk(messageStr: message ?? "Save successfully")
                } else {
                    self.showAlertwithOk(messageStr: message ?? "Error")
                }
            }
        }
    }
    
    //MARK:
    //MARK: Validate Textfield
    private func validateEmployee() -> Bool {
        if fullname == "" {
            //We can show toast here
            self.showAlert(messageStr: "Please enter full name")
            return false
        } else if email == "" {
            self.showAlert(messageStr: "Please enter email")
            return false
        } else if !(email?.isValidEmail())! {
            self.showAlert(messageStr: "Please enter valid email")
            return false
        } else if phoneNuber == "" {
            self.showAlert(messageStr: "Please enter phone number")
            return false
        } else if Int(phoneNuber ?? "0") ?? 0 < 10 {
            self.showAlert(messageStr: "Please enter valid phone number")
            return false
        } else if address == "" {
            self.showAlert(messageStr: "Please enter address")
            return false
        } else if birthDate == "" {
            self.showAlert(messageStr: "Please enter birth date")
            return false
        } else if gender == "" {
            self.showAlert(messageStr: "Please enter gender")
            return false
        } else if desigation == "" {
            self.showAlert(messageStr: "Please enter designation")
            return false
        } else if salary == 0 {
            self.showAlert(messageStr: "Please enter salary")
            return false
        }
        return true
    }
}

extension EmployeeDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LabelWithTextfieldTableViewCell", for: indexPath) as? LabelWithTextfieldTableViewCell else { return UITableViewCell() }
        cell.textfield.isEnabled = !isFromDetails
        arrayOfCells = [cell]
        cell.selectionStyle = .none
        switch (indexPath.row) {
        case 0:
            cell.lblTitle.text = "Full Name"
            cell.textfield.placeholder = "Full Name"
            cell.textfield.text = employeeModel?.fullName
        case 1:
            cell.lblTitle.text = "Email"
            cell.textfield.placeholder = "Email"
            cell.textfield.text = employeeModel?.email
            cell.textfield.keyboardType = .emailAddress
        case 2:
            cell.lblTitle.text = "Phone Number"
            cell.textfield.placeholder = "Phone Number"
            cell.textfield.keyboardType = .numberPad
            cell.textfield.text = employeeModel?.phone
        case 3:
            cell.lblTitle.text = "Address"
            cell.textfield.placeholder = "Address"
            cell.textfield.text = employeeModel?.address
        case 4:
            cell.lblTitle.text = "Birth Date"
            cell.textfield.placeholder = "yyyy-mm-dd" //We can use datepicker insted of userinput
            cell.textfield.text = employeeModel?.dob
        case 5:
            cell.lblTitle.text = "Gender"
            cell.textfield.placeholder = "Gender" //We can put picket view for male & female
            cell.textfield.text = employeeModel?.gender
        case 6:
            cell.lblTitle.text = "Designation"
            cell.textfield.placeholder = "Designation"
            cell.textfield.text = employeeModel?.designation
        case 7:
            cell.lblTitle.text = "Salary"
            cell.textfield.placeholder = "Salary"
            cell.textfield.keyboardType = .decimalPad
            cell.textfield.text = "\(employeeModel?.salary ?? 0)"
        default:
            break
        }
        return cell
    }
}

extension UIViewController {
    func showAlertwithOk(messageStr: String) {
        let alert = UIAlertController(title: "", message: messageStr, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(messageStr:String) {
        
        let alert = UIAlertController(title: "", message: messageStr, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
