//
//  ServerResponseReg.swift
//  GB-Course-CleanCode
//
//  Created by Maksim Volkov on 16.08.2022.
//

import Foundation

struct ServerResponseReg: Codable {
    let result: Int
    let user_message: String
    let error_message: String?
}
