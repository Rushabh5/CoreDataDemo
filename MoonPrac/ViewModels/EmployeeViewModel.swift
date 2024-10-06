//
//  EmployeeViewModel.swift
//  MoonPrac
//
//  Created by RS on 25/06/22.
//

import Foundation
import CoreData
import Alamofire

class EmployeeViewModel: NSObject {
    
    //MARK:
    //MARK: Variable Declaration
    var employeeModel =  [EmployeeData]()
    weak var employeeListVC: EmployeesViewController?
    
    //MARK:
    //MARK: API
    func getEmployeeData(completion: @escaping ((Bool) -> Void)) {
        retrieveData { list in
            if !list.isEmpty {
                self.employeeModel = self.listToData(list: list)
                completion(true)
            } else {
                AF.request("https://beta2.moontechnolabs.com/practical_api/public/api/user").responseData { response in
                    if let data = response.data {
                        do {
                            let resData = try JSONDecoder().decode(EmployeeRootClass.self, from: data)
                            if resData.data?.count ?? 0 > 0 {
                                self.employeeModel = resData.data!
                                DispatchQueue.main.async {
                                    let list = self.createData(empListData: self.employeeModel)
                                    self.employeeModel = self.listToData(list: list)
                                    completion(true)
                                }
                            }
                        } catch let error {
                            completion(false)
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
    
    //MARK:
    //MARK: Crud Operation for Coredata
    private func createData(empListData: [EmployeeData]) -> [Employees] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        var list = [Employees]()
        let resEntity = NSEntityDescription.entity(forEntityName: "Employees", in: managedContext)!
        for i in 0..<empListData.count {
            let emp = NSManagedObject(entity: resEntity, insertInto: managedContext) as! Employees
            //rest.id = Int16(restListData[i].id ?? 0) // We can achive like this as well as.
            emp.setValue(empListData[i].id, forKeyPath: "id")
            emp.setValue(empListData[i].profilePicUrl, forKey: "profile_pic_url")
            emp.setValue(empListData[i].fullName, forKey: "full_name")
            emp.setValue(empListData[i].email, forKey: "email")
            emp.setValue(empListData[i].profilePic, forKey: "profile_pic")
            emp.setValue(empListData[i].phone, forKey: "phone")
            emp.setValue(empListData[i].address, forKey: "address")
            emp.setValue(empListData[i].dob, forKey: "dob")
            emp.setValue(empListData[i].gender, forKey: "gender")
            emp.setValue(empListData[i].designation, forKey: "designation")
            emp.setValue(empListData[i].salary, forKey: "salary")
            emp.setValue(empListData[i].createdAt, forKey: "created_at")
            emp.setValue(empListData[i].updatedAt, forKey: "updated_at")
            
            list.append(emp)
        }
        do {
            print("Data saved...")
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return list
    }
    
    private func retrieveData(onSuccess: @escaping ([Employees]) -> Void)  {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Employees> = Employees.fetchRequest()
        var entites = [Employees]()
        do {
            let result = try managedContext.fetch(fetchRequest)
            entites = result
        } catch {
            print("Failed")
        }
        onSuccess(entites)
    }
    
    private func listToData(list: [Employees]) -> [EmployeeData] {
        return list.map({ EmployeeData(entity: $0) })
    }
    
    func getSearchArray(str:String, list:[EmployeeData]) -> [EmployeeData] {
        var statusEmployee = [EmployeeData]()
        
        let StringCap = str.capitalized
        for model in list {
            if str == ""{
                statusEmployee.append(model)
            }else if model.fullName?.containsIgnoringCase(find: StringCap) == true{
                statusEmployee.append(model)
            }
        }
        return statusEmployee
    }
}


