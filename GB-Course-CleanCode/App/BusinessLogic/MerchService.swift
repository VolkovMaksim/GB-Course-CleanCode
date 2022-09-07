//
//  MerchService.swift
//  GB-Course-CleanCode
//
//  Created by Maksim Volkov on 04.09.2022.
//
import Foundation

final class MerchService {
    
    var merchAndFeedback: [String] = []
    var merchAndPrice: Int = 0
    
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
        let url = configureUrl(method: "/merch")
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
                let result = try decoder.decode(MerchResponse.self, from: data)
                self.merchAndPrice = result.priceInMerchResponse
                self.merchAndFeedback = result.feedbackInMerchResponse
            } catch {
                print(error)
            }
        }
        task.resume()
        sleep(1)
    }
}

private extension MerchService {
    
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
