//
//  SubcategoryViewController.swift
//  YandexMoneyTest
//
//  Created by Андрей on 13/06/2019.
//  Copyright © 2019 Andrey Fokin. All rights reserved.
//

import UIKit

class SubcategoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var category: Category!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        navigationItem.title = category.title
        

    }
    
}

extension SubcategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.subs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubcategoryCell", for: indexPath) as! SubcategoryCell
        cell.configure(with: category.subs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
