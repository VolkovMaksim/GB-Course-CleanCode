//
//  StockService.swift
//  GB-Course-CleanCode
//
//  Created by Maksim Volkov on 03.09.2022.
//

import Foundation

final class StockService {
    
    var stockData = [String: Int]()
    
//    private let scheme = "http"
//    private let host = "127.0.0.1"
//    private let port = 8084
    private let scheme = "https"
    private let host = "dev.rus-volk.ru"
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    
    func request() {
        
        //let resultMessage = ""
        
//        let params: [String: String] = ["email": email,
//                                        "password": password
//        ]
        
        let url = configureUrl(method: "/stock")
        print(url)
        
//        let json: [String: Any] = params

//        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        // create post request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // нужный способ передачи данных на Vapor
//        request.httpBody = jsonData
        // без этого указания Vapor будет писать Bad request
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }

            guard let data = data else { return }
            let decoder = JSONDecoder()

            do {
                let result = try decoder.decode(StockResponse.self, from: data)
                print(result.merchAndPriceInStockResponse)
                self.stockData = result.merchAndPriceInStockResponse
                
                //resultMessage = result.user_message
                //print(resultMessage)
            } catch {
                print(error)
            }
        }
        task.resume()
        sleep(1)
        //return resultMessage
    }
}

private extension StockService {
    
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
