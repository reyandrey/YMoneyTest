//
//  NetworkService.swift
//  YandexMoneyTest
//
//  Created by Андрей on 13/06/2019.
//  Copyright © 2019 Andrey Fokin. All rights reserved.
//

import Foundation

protocol NetworkService: class {
    var session: URLSession { get }
    func getData(from url: URL, completion: @escaping (Data?) -> ())
}

extension NetworkService {
    
    var session: URLSession { return URLSession.shared }
    
    func getData(from url: URL, completion: @escaping (Data?) -> ()) {
        session.dataTask(with: url) { (data, response, error) in
            guard error == nil,
                let response = response as? HTTPURLResponse else {
                    print("[NetworkService] \(#function) failed with error")
                    completion(nil)
                    return
            }
            
            guard response.statusCode == 200 else {
                print(print("[NetworkService] \(#function) failed - response status code not OK"))
                completion(nil)
                return
            }
            
            guard let data = data else {
                print(print("[NetworkService] \(#function) failed - no data"))
                completion(nil)
                return
            }
            
            completion(data)
            
        }.resume()
    }
}

