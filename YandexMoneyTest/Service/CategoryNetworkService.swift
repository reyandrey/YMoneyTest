//
//  CategoryNetworkService.swift
//  YandexMoneyTest
//
//  Created by Андрей on 13/06/2019.
//  Copyright © 2019 Andrey Fokin. All rights reserved.
//

import Foundation

final class CategoryNetworkService: NetworkService {
    private init() {}
    static let shared = CategoryNetworkService()
    
    private let url = URL(string: "https://money.yandex.ru/api/categories-list")!
    
    public func fetchCategories(completion: @escaping ([Category]?)->()) {
        DispatchQueue.global().async {
            self.getData(from: self.url) { (data) in
                guard let data = data else { completion(nil); return }
                guard let items = try? JSONDecoder().decode([Category].self, from: data) else {
                    print("[CategoryNetworkService] \(#function) JSON decode failed")
                    completion(nil)
                    return
                }
                DispatchQueue.main.async {
                    completion(items)
                }
            }
        }
        
    }
}
