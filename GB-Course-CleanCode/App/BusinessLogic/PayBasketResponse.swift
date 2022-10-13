//
//  PayBasketResponse.swift
//  GB-Course-CleanCode
//
//  Created by Maksim Volkov on 02.10.2022.
//

import Foundation

struct PayBasketResponse: Codable {
    let cart_message: String
    let error_message: String?
}
