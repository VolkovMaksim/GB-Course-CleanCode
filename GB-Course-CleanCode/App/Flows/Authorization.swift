//
//  Authorization.swift
//  GB-Course-CleanCode
//
//  Created by Maksim Volkov on 28.06.2022.
//

import Foundation

class Authorization {
    var email = "" // Получаем значение из TextFieldEmail
    var password = "" // Получаем значение из TextFieldPassword
    
    func tryLogin(userPass: String) -> Bool {
        // такой метод используется при условии, что пользователь ранее регистрировался и введенный email является правильным
        if userPass == Registration().registeredUsers.string(forKey: email) {
            // заходим в приложение, например в экран редактирования данных
            return true
        } else {
            // Показываем алерт "Неудачная попытка входа"
            return false
        }
    }
    
    
}
