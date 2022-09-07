//
//  CurrentUserData.swift
//  GB-Course-CleanCode
//
//  Created by Maksim Volkov on 14.08.2022.
//

import Foundation

class CurrentUserData {

    static let instance = CurrentUserData()

    private init() {}

    var email: String?
    //var userId: Int?
}
