//
//  ViewController.swift
//  MoonPrac
//
//  Created by RS on 25/06/22.
//

import UIKit

class EmployeesViewController: UIViewController {
    
    //MARK: Outlet and Property
    @IBOutlet private weak var searchbar: UISearchBar!
    @IBOutlet private weak var empTableView: UITableView!
    
    private var employeeListVM = EmployeeViewModel()
    private var employeeModel =  [EmployeeData]()
    
    //MARK:
    //MARK: UIViewcontroller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.employeeListVM.getEmployeeData { result in
            DispatchQueue.main.async {
                self.employeeModel = self.employeeListVM.employeeModel
                self.empTableView.reloadData()
            }
        }
    }
    
    private func setupUI() {
        empTableView.backgroundView = UIView()
        navigationItem.backButtonTitle = ""

        empTableView.register(UINib(nibName: "EmployeeTableViewCell", bundle: nil), forCellReuseIdentifier: "EmpCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))

    }
    
    //MARK:
    //MARK: UIButton Action Method
    @objc private func addTapped() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EmployeeDetailViewController") as? EmployeeDetailViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @objc private func editTapped() {
        print("Edit")
    }
}

//MARK:
//MARK: UISearchBar delegate
extension EmployeesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        employeeModel = self.employeeListVM.getSearchArray(str: searchText, list: employeeListVM.employeeModel)
        self.empTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchbar.endEditing(true)
    }
}

//MARK: UITableview Datasource and Delegate
extension EmployeesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmpCell", for: indexPath) as? EmployeeTableViewCell else { return UITableViewCell() }
        cell.setEmployeeData(employeeData: employeeListVM.employeeModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EmployeeDetailViewController") as? EmployeeDetailViewController
        vc?.employeeModel = employeeListVM.employeeModel[indexPath.row]
        vc?.isFromDetails = true
        self.navigationController?.pushViewController(vc!, animated: true)

    }
}
