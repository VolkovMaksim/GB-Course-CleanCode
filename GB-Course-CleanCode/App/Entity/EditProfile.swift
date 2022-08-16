//
//  EditProfile.swift
//  GB-Course-CleanCode
//
//  Created by Maksim Volkov on 28.06.2022.
//

import Foundation

class EditProfile {
    var firstName = "" // Получаем значение из TextFieldFirstName
    var lastName = "" // Получаем значение из TextFieldLastName
    var newPassword = "" // Получаем значение из TextFieldNewPassword
    
    let usersFirstName = UserDefaults.standard
    let usersLastName = UserDefaults.standard
    
    func setUsersFirstName() {
        usersFirstName.set(firstName, forKey: Registration().email)
    }
    
    func setUsersLastName() {
        usersLastName.set(lastName, forKey: Registration().email)
    }
    
    func setUsersNewPassword() {
        Registration().registeredUsers.set(newPassword, forKey: Registration().email)
    }
}
