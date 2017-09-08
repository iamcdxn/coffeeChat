//
//  ProductTitleTVC.swift
//  PROCH
//
//  Created by CdxN on 2017/8/19.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import UIKit

class ProductTitleTVC: UITableViewCell {
    @IBOutlet var productName: UILabel!
    @IBOutlet var productOrigin: UILabel!
    @IBOutlet var productProcess: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
