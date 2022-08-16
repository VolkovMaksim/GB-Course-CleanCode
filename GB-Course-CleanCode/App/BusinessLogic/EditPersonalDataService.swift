//
//  EditPersonalDataService.swift
//  GB-Course-CleanCode
//
//  Created by Maksim Volkov on 16.08.2022.
//

import Foundation

final class EditPersonalDataService {
    
    //    private let scheme = "http"
    //    private let host = "192.168.100.10"
    //    private let port = 8084
        private let scheme = "https"
        private let host = "dev.rus-volk.ru"
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    
    func request(username: String, email: String, password: String, creditcard: String) -> String {
        
        var resultMessage = ""
        // создаем словарь для отправки данных пользователя на сервер
        let params: [String: Any] = ["username": username,
                                    "email": email,
                                    "password": password,
                                    "credit_card": creditcard
        ]
        // добавляем метод для регистрации
        let url = configureUrl(method: "/editpersonaldata")
        print(url)

        // создаем data с данными пользователя
        let jsonData = try? JSONSerialization.data(withJSONObject: params)

        // create post request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // нужный способ передачи данных на Vapor
        request.httpBody = jsonData
        // без этого указания Vapor будет писать Bad request
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
//            print("-------------")
//            print("Response \(response)")
//            print("-------------")
            guard let data = data else { return }
            let decoder = JSONDecoder()

            do {
                let result = try decoder.decode(ServerResponseEdit.self, from: data)
                resultMessage = result.user_message
                print(resultMessage)
            } catch {
                print(error)
            }
        }
        task.resume()
        sleep(1)
        return resultMessage
    }
}

private extension EditPersonalDataService {
    
    func configureUrl(method: String) -> URL {
        //var queryItems = [URLQueryItem]()

        //

        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
//        urlComponents.port = port
        urlComponents.path = method
        //urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else {
            fatalError("URL is invalid")
        }
        
        return url
    }
}
