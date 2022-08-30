//
//  ServerResponseAuth.swift
//  GB-Course-CleanCode
//
//  Created by Maksim Volkov on 16.08.2022.
//

import Foundation

struct ServerResponseAuth: Codable {
    let result: Int
    let user_message: String
    let username: String?
    let email: String?
    let password: String?
    let credit_card: String?
    let error_message: String?
}
