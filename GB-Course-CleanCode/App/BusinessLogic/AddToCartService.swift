//
//  AddToCartService.swift
//  GB-Course-CleanCode
//
//  Created by Maksim Volkov on 07.09.2022.
//

import Foundation

final class AddToCartService {
    
    var cartMessage: String = ""
    
    private let scheme = "http"
    private let host = "127.0.0.1"
    private let port = 8084
//        private let scheme = "https"
//        private let host = "dev.rus-volk.ru"
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    
    func request(merchname: String) {
        
        // создаем словарь для отправки данных пользователя на сервер
        let params: [String: String] = ["merchname": merchname]
        // добавляем метод для регистрации
        let url = configureUrl(method: "/addtocart")
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
            guard let data = data else { return }
            let decoder = JSONDecoder()

            do {
                let result = try decoder.decode(AddToCartResponse.self, from: data)
                self.cartMessage = result.cart_message
            } catch {
                print(error)
            }
        }
        task.resume()
        sleep(1)
    }
}

private extension AddToCartService {
    
    func configureUrl(method: String) -> URL {
        //var queryItems = [URLQueryItem]()

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
