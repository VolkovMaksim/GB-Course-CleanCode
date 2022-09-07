//
//  MerchResponse.swift
//  GB-Course-CleanCode
//
//  Created by Maksim Volkov on 04.09.2022.
//

import Foundation

struct MerchResponse: Codable {
    let priceInMerchResponse: Int
    let feedbackInMerchResponse: [String]
    let error_message: String?
}
