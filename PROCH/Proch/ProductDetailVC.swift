//
//  ProductDetailVC.swift
//  PROCH
//
//  Created by CdxN on 2017/8/19.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import UIKit

class ProductDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var productDetailTableView: UITableView!
    var fullSize: CGSize!
    var product = CoffeeBean(name: "耶加雪啡", origin: "瓜地馬拉", flavor: "草莓  桃子  鳳梨", picture: UIImage(named: "KoffeeKult")!, process: "日曬  淺焙", quote: "像淡淡的蜂蜜，喝得到陽光下花朵的味道。", rates: CoffeeBeanRate(aftertaste: 3, acidity: 4, sweet: 3, aroma: 4, body: 2), parameters: CoffeeBeanParameter(weight: 30, capacity: 300, temperature: 92, timeMinute: 02, timeSecond: 30))

    override func viewDidLoad() {
        super.viewDidLoad()

        fullSize = UIScreen.main.bounds.size

        productDetailTableView.estimatedRowHeight = 150
        productDetailTableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: ProductBannerTVC = tableView.dequeueReusableCell(withIdentifier: "productBanner") as! ProductBannerTVC
            cell.contentView.backgroundColor = UIColor.clear
            cell.productPic.image = product.picture
            cell.subTitle.setLineHeight(lineHeight: 10.0)
            cell.subTitle.textAlignment = .right
            return cell

        } else if indexPath.section == 1 {
            let cell: ProductTitleTVC = tableView.dequeueReusableCell(withIdentifier: "productTitle") as! ProductTitleTVC
            
            cell.productName.text = product.name
            cell.productOrigin.text = product.origin
            cell.productProcess.text = product.process
            cell.contentView.backgroundColor = UIColor.clear
            return cell

        } else if indexPath.section == 2 {
            let cell: ProductFlavorTVC = tableView.dequeueReusableCell(withIdentifier: "productFlavor") as! ProductFlavorTVC

            cell.productFlavor.text = product.flavor
            cell.contentView.backgroundColor = UIColor.clear

            return cell

        } else if indexPath.section == 3 {
            let cell: ProductQuoteTVC = tableView.dequeueReusableCell(withIdentifier: "productQuote") as! ProductQuoteTVC

            cell.productQuote.text = product.quote
            cell.contentView.backgroundColor = UIColor.clear

            return cell

        } else if indexPath.section == 4 {
            let cell: ProductRateTVC = tableView.dequeueReusableCell(withIdentifier: "productRate") as! ProductRateTVC

            cell.rateAcidity.text = String(Int(product.rates.acidity))
            cell.rateBody.text = String(Int(product.rates.body))
            cell.rateAroma.text = String(Int(product.rates.aroma))
            cell.rateSweet.text = String(Int(product.rates.sweet))
            cell.rateAftertaste.text = String(Int(product.rates.aftertaste))

            let rateTotalWidth = fullSize.width - 80 - 40 - 80 - 10
            let perwidth = rateTotalWidth / 5

            cell.constraintAcidity.constant = 20 + perwidth * CGFloat(5 - product.rates.acidity)
            cell.constraintBody.constant = 20 + perwidth * CGFloat(5 - product.rates.body)
            cell.constraintAroma.constant = 20 + perwidth * CGFloat(5 - product.rates.aroma)
            cell.constraintSweet.constant = 20 + perwidth * CGFloat(5 - product.rates.sweet)
            cell.constraintAftertasteView.constant = 20 + perwidth * CGFloat(5 - product.rates.aftertaste)
            cell.contentView.backgroundColor = UIColor.clear

            return cell

        } else {
            let cell: ProductParametersTVC = tableView.dequeueReusableCell(withIdentifier: "productParameters") as! ProductParametersTVC
            let constraint = (fullSize.width - 160 - 80) / 3
            cell.parametersConstraintLeft.constant = constraint
            cell.parametersConstraintRight.constant = constraint
            
            cell.weight.text = "\(product.parameters.weight)g"
            cell.capacity.text = "\(product.parameters.capacity)ml"
            cell.temperature.text = "\(product.parameters.temperature)℃"
            cell.time.text = "\(product.parameters.timeMinute):\(product.parameters.timeSecond)"
            cell.contentView.backgroundColor = UIColor.clear

            return cell

        }
    }
}
