//
//  CategoryViewController.swift
//  YandexMoneyTest
//
//  Created by Андрей on 12/06/2019.
//  Copyright © 2019 Andrey Fokin. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var categories: [Category] = [Category]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private var refreshControl: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        navigationItem.backBarButtonItem?.title = ""
        navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
        navigationItem.largeTitleDisplayMode = .always
        
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: .primaryActionTriggered)
        tableView.refreshControl = refreshControl

        fetchCategories()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if (segue.identifier == "showSubcategorySegue") {
            
            guard let destinationVC = segue.destination as? SubcategoryViewController,
                  let sender = sender as? CategoryViewController,
                  let selectedRow = tableView.indexPathForSelectedRow?.row else { return }
            
            destinationVC.category = sender.categories[selectedRow]
        }
    }
    
    fileprivate func fetchCategories() {
        CategoryNetworkService.shared.fetchCategories { (fetchedItems) in
            guard let fetchedItems = fetchedItems else {
                let alert = UIAlertController(title: "Ошибка", message: "Не удалось загрузить данные", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ок", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true) {
                    self.categories = [Category]() // self.fetchCategories()
                }
                return
            }
            self.categories = fetchedItems
        }
    }
    
    @objc fileprivate func refreshControlAction(_ sender: AnyObject?) {
        fetchCategories()
        refreshControl.endRefreshing()
    }
}

extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.configure(with: categories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showSubcategorySegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
