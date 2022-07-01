//
//  Registration.swift
//  GB-Course-CleanCode
//
//  Created by Maksim Volkov on 28.06.2022.
//

import Foundation

class Registration {
    var email = ""
    var password = ""
    var confirmPassword = ""
    let registeredUsers = UserDefaults.standard
    
    func comparePassword(password: String, confirmPassword: String) -> Bool {
        if (password == confirmPassword) && (!password.isEmpty && !confirmPassword.isEmpty) {
            registrationUser()
            return true
        } else {
            // возвращаем false, VC показывает уведомление о несоответствии данных
            return false
        }
    }
    
    func registrationUser() {
            registeredUsers.set(password, forKey: email)
        // возвращаемся на экран авторизации
    }
}
