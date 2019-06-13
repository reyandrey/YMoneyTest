//
//  SubcategoryCell.swift
//  YandexMoneyTest
//
//  Created by Андрей on 12/06/2019.
//  Copyright © 2019 Andrey Fokin. All rights reserved.
//

import UIKit

class SubcategoryCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(with sub: Subcategory) {
        self.titleLabel.text = sub.title
    }

}
