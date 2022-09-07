//
//  StockResponse.swift
//  GB-Course-CleanCode
//
//  Created by Maksim Volkov on 03.09.2022.
//

import Foundation

struct StockResponse: Codable {
    //let result: Int
//    let user_message: String
    let merchAndPriceInStockResponse: [String: Int]
    let error_message: String?
}
