//
//  Model.swift
//  SimpleCrudMySQL
//
//  Created by Zakki Mudhoffar on 23/06/23.
//

import Foundation
import SwiftUI

struct DataModel: Decodable {
    let error: Bool
    let message: String
    let data: [UserModel]
}

struct UserModel: Codable {
    let id: Int
    let fullname: String
    let username: String
    let password: String?
    let status: String?
    
//    enum CodingKeys: String, CodingKey
//    {
//        case id = "id"
//        case fullname = "fullname"
//        case username = "username"
//        case password = "password"
//        case status = "status"
//    }
}


