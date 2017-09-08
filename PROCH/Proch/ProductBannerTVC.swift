//
//  ProductBannerTVC.swift
//  PROCH
//
//  Created by CdxN on 2017/8/19.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import UIKit

class ProductBannerTVC: UITableViewCell {

    @IBOutlet var productPic: UIImageView!
    @IBOutlet var bannerTitle: UITextField!
    @IBOutlet var subTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
