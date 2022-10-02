//
//  AuthorizationService.swift
//  GB-Course-CleanCode
//
//  Created by Maksim Volkov on 07.08.2022.
//

import Foundation

final class AuthorizationService {
    
    let authorizedUsersData = UserDefaults.standard
    var userData = [String:String]()
    
    private let scheme = "http"
    private let host = "127.0.0.1"
    private let port = 8084
//    private let scheme = "https"
//    private let host = "dev.rus-volk.ru"
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    
    func request(email: String, password: String) -> String {
        
        var resultMessage = ""
        
        let params: [String: String] = ["email": email,
                                        "password": password
        ]
        
        let url = configureUrl(method: "/authorization")
        print(url)
        
        let json: [String: Any] = params

        let jsonData = try? JSONSerialization.data(withJSONObject: json)

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

            guard let data = data else { return }
            let decoder = JSONDecoder()

            do {
                let result = try decoder.decode(ServerResponseAuth.self, from: data)
                if result.result == 1 {
                    self.userData["username"] = result.username
                    self.userData["email"] = result.email
                    self.userData["password"] = result.password
                    self.userData["credit_card"] = result.credit_card
                    self.authorizedUsersData.set(self.userData, forKey: result.email!)
                    
                }
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

private extension AuthorizationService {
    
    func configureUrl(method: String) -> URL {
        //var queryItems = [URLQueryItem]()

        //

        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.port = port
        urlComponents.path = method
        //urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else {
            fatalError("URL is invalid")
        }
        
        return url
    }
}
