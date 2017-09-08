//
//  ProductRateTVC.swift
//  PROCH
//
//  Created by CdxN on 2017/8/19.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import UIKit

class ProductRateTVC: UITableViewCell {
    @IBOutlet var rateAftertaste: UILabel!
    @IBOutlet var rateAcidity: UILabel!
    @IBOutlet var rateSweet: UILabel!
    @IBOutlet var rateAroma: UILabel!
    @IBOutlet var rateBody: UILabel!

    @IBOutlet var constraintAftertasteView: NSLayoutConstraint!
    @IBOutlet var constraintAcidity: NSLayoutConstraint!
    @IBOutlet var constraintSweet: NSLayoutConstraint!
    @IBOutlet var constraintAroma: NSLayoutConstraint!
    @IBOutlet var constraintBody: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
