//
//  Category.swift
//  YandexMoneyTest
//
//  Created by Андрей on 12/06/2019.
//  Copyright © 2019 Andrey Fokin. All rights reserved.
//

import Foundation

struct Category: Decodable {
    let title: String
    let subs: [Subcategory]
}

struct Subcategory: Decodable {
    let id: Int
    let title: String
}

// MARK: - Test
//extension Category {
//    static func fetchCategoryTree(completion: @escaping ([Category])->()) {
//        DispatchQueue.global().async {
//            var fetchedItems: [Category]?
//            let url = URL(string: "https://money.yandex.ru/api/categories-list")!
//            guard let data = try? Data(contentsOf: url) else { return }
//            
//            do {
//                let result = try JSONDecoder().decode([Category].self, from: data) as [Category]
//                fetchedItems = result
//            }
//            catch {
//                print(error)
//            }
//            
//            guard let items = fetchedItems else { return }
//            
//            DispatchQueue.main.async {
//                completion(items)
//            }
//        }
//    }
//}
