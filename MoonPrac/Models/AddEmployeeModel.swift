//
//  AddEmployeeModel.swift
//  MoonPrac
//
//  Created by RS on 25/06/22.
//

import Foundation

struct AddEmployeeRootClass : Codable {

    let code : Int?
    let data : [String]?
    let msg : String?
    let status : Bool?
    let version : String?


    enum CodingKeys: String, CodingKey {
        case code = "code"
        case data = "data"
        case msg = "msg"
        case status = "status"
        case version = "version"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        data = try values.decodeIfPresent([String].self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        version = try values.decodeIfPresent(String.self, forKey: .version)
    }
}
