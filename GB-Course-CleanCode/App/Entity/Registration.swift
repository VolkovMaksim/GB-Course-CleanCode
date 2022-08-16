//
//  Registration.swift
//  GB-Course-CleanCode
//
//  Created by Maksim Volkov on 28.06.2022.
//

import Foundation

class Registration {
    var email = "".lowercased()
    var password = ""
    var confirmPassword = ""
    let registeredUsers = UserDefaults.standard
    
    func comparePassword(password: String, confirmPassword: String) -> Bool {
        if (password == confirmPassword) && (!password.isEmpty && !confirmPassword.isEmpty) {
            return registrationUser()
        } else {
            // возвращаем false, VC показывает уведомление о несоответствии данных
            return false
        }
    }
    
    func registrationUser() -> Bool {
        registeredUsers.set(password, forKey: email.lowercased())
        return true
        // возвращаемся на экран авторизации
    }
}
