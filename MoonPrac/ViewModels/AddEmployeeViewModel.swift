//
//  AddEmployeeViewModel.swift
//  MoonPrac
//
//  Created by RS on 25/06/22.
//

import Foundation
import Alamofire

class EmployeeDetailViewModel: NSObject {
    func saveEmployeeData(param: [String: Any], _ completion: @escaping(_ status: Bool?, _ message: String?) -> ())  {
        AF.request("https://beta2.moontechnolabs.com/practical_api/public/api/user", method: .post, parameters: param, encoding: JSONEncoding.default).responseData { response in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let resData = try JSONDecoder().decode(AddEmployeeRootClass.self, from: data)
                        completion(resData.status, resData.msg)
                    } catch let error {
                        completion(false, error.localizedDescription)
                    }
                }
            case .failure(let error):
                completion(false, error.errorDescription)
            }
        }
    }
}


