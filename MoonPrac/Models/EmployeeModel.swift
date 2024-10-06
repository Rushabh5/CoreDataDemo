//
//  EmployeeModel.swift
//  MoonPrac
//
//  Created by RS on 25/06/22.
//

import Foundation

struct EmployeeRootClass : Codable {

    let code : Int?
    let data : [EmployeeData]?
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
        data = try values.decodeIfPresent([EmployeeData].self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        version = try values.decodeIfPresent(String.self, forKey: .version)
    }
}

struct EmployeeData : Codable {

    let address : String?
    let createdAt : String?
    let designation : String?
    let dob : String?
    let email : String?
    let fullName : String?
    let gender : String?
    let id : Int?
    let phone : String?
    let profilePic : String?
    let profilePicUrl : String?
    let salary : Int?
    let updatedAt : String?


    enum CodingKeys: String, CodingKey {
        case address = "address"
        case createdAt = "created_at"
        case designation = "designation"
        case dob = "dob"
        case email = "email"
        case fullName = "full_name"
        case gender = "gender"
        case id = "id"
        case phone = "phone"
        case profilePic = "profile_pic"
        case profilePicUrl = "profile_pic_url"
        case salary = "salary"
        case updatedAt = "updated_at"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        designation = try values.decodeIfPresent(String.self, forKey: .designation)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        profilePic = try values.decodeIfPresent(String.self, forKey: .profilePic)
        profilePicUrl = try values.decodeIfPresent(String.self, forKey: .profilePicUrl)
        salary = try values.decodeIfPresent(Int.self, forKey: .salary)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }

    init(entity: Employees) {
        id = Int(entity.id)
        address = entity.address
        fullName = entity.full_name
        email = entity.email
        profilePicUrl = entity.profile_pic_url
        createdAt = entity.created_at
        profilePic = entity.profile_pic
        phone = entity.phone
        dob = entity.dob
        gender = entity.gender
        designation = entity.designation
        salary = Int(entity.salary)
        updatedAt = entity.updated_at
    }

}
