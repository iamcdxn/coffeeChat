//
//  MakingCoffeeVC.swift
//  PROCH
//
//  Created by CdxN on 2017/8/14.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import UIKit
import ApiAI

class MakingCoffeeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate, ApiAIManagerDelegate {

    let myVcType = "makingCoffee"
    var response: ApiAIResponse!
    var apiAIResponseManager = ApiAIManager()

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var productsCollectionView: UICollectionView!
    @IBOutlet var makingGif: UIImageView!
    let products = ["希臘輕度烘培", "青檸乳酪蛋糕", "剛果曼特寧", "焦糖咖啡粉", "蘇門答臘深烘焙"]

    var btns: [UIButton]!
    var speeches = [String]()
    var btnString = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigaitonFontsAndColor()
        print("globalResponseis: \(globalResponse)")

        apiAIResponseManager.delegate = self

        productsCollectionView.backgroundColor = UIColor.clear
        makingGif.loadGif(name: "makingCoffeeCup")
        titleTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
        titleTextField.text?.removeAll()
        subtitleLabel.text?.removeAll()
        titleTextField.textColor = UIColor.black

        titleTextField.attributedPlaceholder = NSAttributedString(string: "Global Title is empty :(", attributes: [NSForegroundColorAttributeName: UIColor.Proch.Green.ProchGreen])

        if globalResponse.titles.count >= 1 {
            titleTextField.attributedPlaceholder = NSAttributedString(string: globalResponse.titles[0], attributes: [NSForegroundColorAttributeName: UIColor.Proch.Green.ProchGreen])
        }

        if globalResponse.titles.count >= 2 {
            subtitleLabel.text = globalResponse.titles[1]
        }

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        //        textField.placeholder = textField.text
        if let text = self.titleTextField.text, text != "" {
            queryProch(query: text)
        } else { }

        return true
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "products", for: indexPath) as? MakingPageProductsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.productName.text = products[indexPath.row]
        cell.productImage.image = UIImage(named: products[indexPath.row])

        let productLabelBorderWidth = 0.2
        cell.bgView.layer.borderWidth = CGFloat(productLabelBorderWidth)
        cell.bgView.backgroundColor = UIColor.white
        cell.bgView.layer.cornerRadius = 1

        cell.bgView.layer.borderColor = UIColor(red: 74.0/255.0, green: 74.0/255.0, blue: 74.0/255.0, alpha: 1.0).cgColor
        cell.bgView.layer.shadowColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        cell.bgView.layer.shadowRadius = 2.0
        cell.bgView.layer.shadowOpacity = 1.0
        cell.bgView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        cell.bgView.layer.masksToBounds =  true

        return cell
    }

    //選Cell跳到下一頁
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toProductSeries", sender: self)
        // note: memory increasing still happen
        //self.dismiss(animated: true, completion: {})
    }

    func queryProch(query: String) {
        self.titleTextField.text?.removeAll()
        self.subtitleLabel.text?.removeAll()

        apiAIResponseManager.requestBotResponse(query: query)
    }
    
    func manager(_ manager: ApiAIManager, didGet response: ApiAIResponse) {
        self.response = response

        self.switchVC(vcType: self.response.vcType, currentVcType: self.myVcType)

        if self.response.titles.count >= 1 {
            self.titleTextField.attributedPlaceholder = NSAttributedString(string: self.response.titles[0], attributes: [NSForegroundColorAttributeName: UIColor.Proch.Green.ProchGreen])
        }

        if self.response.titles.count >= 2 {
            if self.response.titles[0] != self.response.titles[1] {
                self.subtitleLabel.text = self.response.titles[1]
            }
        }
        globalResponse = self.response
    }

    func manager(_ manager: ApiAIManager, didFailWith error: Error) {
        print("Do not Get Response From ApiAI")
    }

}
