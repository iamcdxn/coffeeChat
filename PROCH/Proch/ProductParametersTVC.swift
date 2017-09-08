//
//  ProductParametersTVC.swift
//  PROCH
//
//  Created by CdxN on 2017/8/19.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import UIKit

class ProductParametersTVC: UITableViewCell {

    @IBOutlet var weight: UILabel!
    @IBOutlet var capacity: UILabel!
    @IBOutlet var temperature: UILabel!
    @IBOutlet var time: UILabel!

    @IBOutlet var parametersConstraintLeft: NSLayoutConstraint!
    @IBOutlet var parametersConstraintRight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
