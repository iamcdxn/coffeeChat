//
//  ProductSeriesVC.swift
//  PROCH
//
//  Created by CdxN on 2017/8/15.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import UIKit
import ApiAI

class ProductSeriesVC: UIViewController, UIScrollViewDelegate, UITextFieldDelegate, ApiAIManagerDelegate {

    let myVcType = "makingCoffee"
    var response: ApiAIResponse!
    var apiAIResponseManager = ApiAIManager()

    var myScrollView: UIScrollView!
    var pageControl: UIPageControl!
    var fullSize: CGSize!

    var products: [SeriesProduct]!
    var myLabel: [UILabel]!
    var myButton: [UIButton]!
    
    var selectedCoffeeBean: CoffeeBean!

    @IBOutlet var titleTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        apiAIResponseManager.delegate = self

        self.title = "商城"

        self.hideKeyboardWhenTappedAround()

        titleTextField.text = ""
        titleTextField.textColor = UIColor.black
        titleTextField.attributedPlaceholder = NSAttributedString(string: "這麼早跟你說，就是要你手刀搶購！", attributes: [NSForegroundColorAttributeName: UIColor.Proch.Green.ProchGreen])
        titleTextField.delegate = self

        products = [SeriesProduct]()

        products.append(SeriesProduct(name: "耶加雪非", picture: UIImage(named: "BreackfastBlend")!, price: 400))
        products.append(SeriesProduct(name: "瓜地馬拉淺焙", picture: UIImage(named: "JuanValdez")!, price: 450))
        products.append(SeriesProduct(name: "哥倫比亞重烘焙", picture: UIImage(named: "KoffeeKult")!, price: 470))
        products.append(SeriesProduct(name: "尼泊爾超重焙", picture: UIImage(named: "Aromistico")!, price: 420))
        products.append(SeriesProduct(name: "皇家級中等烘焙", picture: UIImage(named: "MediumRoast")!, price: 490))

        // 取得螢幕的尺寸
        fullSize = UIScreen.main.bounds.size

        // 建立 UIScrollView
        myScrollView = UIScrollView()

        // 設置尺寸 也就是可見視圖範圍
        myScrollView.frame = CGRect(x: 0, y: 20, width: fullSize.width - 170, height: fullSize.height - 20)

        // 實際視圖範圍
        myScrollView.contentSize = CGSize(width: (fullSize.width - 170) * 5, height: fullSize.height - 20)

        // 是否顯示滑動條
        myScrollView.showsHorizontalScrollIndicator = false
        myScrollView.showsVerticalScrollIndicator = false

        // 滑動超過範圍時是否使用彈回效果
        myScrollView.bounces = true

        // 設置委任對象
        myScrollView.delegate = self

        // 以一頁為單位滑動
        myScrollView.isPagingEnabled = true

        myScrollView.backgroundColor = UIColor.clear

        myScrollView.clipsToBounds = false

        // 加入到畫面中
        self.view.addSubview(myScrollView)

        // 建立 UIPageControl 設置位置及尺寸
        pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: fullSize.width * 0.85, height: 50))
        pageControl.center = CGPoint(x: fullSize.width * 0.5, y: fullSize.height * 0.85)

        pageControl.numberOfPages = 5

        pageControl.currentPage = 0

        pageControl.currentPageIndicatorTintColor = UIColor(red: 65.0/255.0, green: 117.0/255.0, blue: 5.0/255.0, alpha: 1.0)

        pageControl.pageIndicatorTintColor = UIColor.lightGray

        pageControl.addTarget(self, action: #selector(ProductSeriesVC.pageChanged), for: .valueChanged)

        self.view.addSubview(pageControl)

        myLabel = [UILabel]()
        myButton = [UIButton]()

        for i in 0...4 {

            // set UILabel
            myLabel.append(UILabel(frame: CGRect(x: 0, y: 0, width: fullSize.width - 170, height: 50)))
            myLabel[i].center = CGPoint(x: (fullSize.width - 170) * (0.85 + CGFloat(i)), y: fullSize.height - 200)
            myLabel[i].font = UIFont(name: "Helvetica-Bold", size: 16.0)
            myLabel[i].textAlignment = .center
            myLabel[i].backgroundColor = UIColor.clear
            myLabel[i].numberOfLines = 0
            myLabel[i].text = "\(self.products[i].name)\nNTD \(self.products[i].price)"
            myLabel[i].alpha = 0.2
            myScrollView.addSubview(myLabel[i])

            // set Image
            myButton.append(UIButton(frame: CGRect(x: 0, y: 0, width: 250.0, height: 250.0)))
            myButton[i].setImage(self.products[i].picture, for: .normal)
            myButton[i].contentHorizontalAlignment = UIControlContentHorizontalAlignment.fill
            myButton[i].contentVerticalAlignment = UIControlContentVerticalAlignment.fill
            myButton[i].backgroundColor = UIColor.clear
            myButton[i].center = CGPoint(x: (fullSize.width - 170) * (0.85 + CGFloat(i)), y: fullSize.height - 360)
            myButton[i].alpha = 0.2
            myButton[i].tag = i
            myButton[i].addTarget(self, action: #selector(self.handleTap(sender:)), for: .touchUpInside)
            myScrollView.addSubview(myButton[i])
        }

        myLabel[0].alpha = 1.0
        myButton[0].alpha = 1.0

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        //        textField.placeholder = textField.text
        if let text = self.titleTextField.text, text != "" {
            queryProch(query: text)
        } else { }

        return true
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)

        print("contentOffset: \(scrollView.contentOffset.x)")
        print("scrollViewWidth: \(scrollView.frame.size.width)")
        print("page = \(page)")

        pageControl.currentPage = page

        for i in 0...4 {

            if i == page {
                UIView.animate(withDuration: 0.5) {
                    self.myButton[i].alpha = 1.0
                    self.myLabel[i].alpha = 1.0
                }
            } else {
                UIView.animate(withDuration: 0.5) {
                    self.myButton[i].alpha = 0.2
                    self.myLabel[i].alpha = 0.2
                }
            }
        }
    }

    func pageChanged(sender: UIPageControl) {
        // 依照目前圓點在的頁數算出位置
        var frame = myScrollView.frame
        frame.origin.x = frame.size.width * CGFloat(sender.currentPage)
        frame.origin.y = 0

        // 再將 UIScrollView 滑動到該點
        myScrollView.scrollRectToVisible(frame, animated: true)
    }

    func queryProch(query: String) {
        self.titleTextField.text?.removeAll()

        apiAIResponseManager.requestBotResponse(query: query)
    }
    
    func manager(_ manager: ApiAIManager, didGet response: ApiAIResponse) {
        self.response = response

        self.switchVC(vcType: self.response.vcType, currentVcType: self.myVcType)

        if self.response.titles.count >= 1 {
            self.titleTextField.attributedPlaceholder = NSAttributedString(string: self.response.titles[0], attributes: [NSForegroundColorAttributeName: UIColor.Proch.Green.ProchGreen])
        }

        globalResponse = self.response
    }

    func manager(_ manager: ApiAIManager, didFailWith error: Error) {
        print("Do not Get Response From ApiAI")
    }
    func handleTap(sender: UIButton) {
        selectedCoffeeBean = coffeeBeanIs(sender: sender.tag)
        performSegue(withIdentifier: "toProductDetailPage", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ProductDetailVC {
            destinationVC.product = selectedCoffeeBean
        }
    }

    func coffeeBeanIs(sender: Int) -> CoffeeBean {
        
        switch sender {
        case 0:
            return CoffeeBean(name: "耶加雪非", origin: "衣索比雅", flavor: "焦糖  櫻桃  鳳梨", picture: UIImage(named: "BreackfastBlend")!, process: "日曬  淺焙", quote: "像淡淡的蜂蜜，喝得到陽光下花朵的味道。", rates: CoffeeBeanRate(aftertaste: 4, acidity: 5, sweet: 3, aroma: 2, body: 2), parameters: CoffeeBeanParameter(weight: 30, capacity: 300, temperature: 92, timeMinute: 02, timeSecond: 30))
        case 1:
            return CoffeeBean(name: "瓜地馬拉淺焙", origin: "瓜地馬拉", flavor: "奶油  萊姆  荔枝", picture: UIImage(named: "JuanValdez")!, process: "日曬  淺焙", quote: "像淡淡的蜂蜜，喝得到陽光下花朵的味道。", rates: CoffeeBeanRate(aftertaste: 3, acidity: 4, sweet: 2, aroma: 3, body: 5), parameters: CoffeeBeanParameter(weight: 30, capacity: 300, temperature: 92, timeMinute: 02, timeSecond: 30))
        case 2:
            return CoffeeBean(name: "哥倫比亞重烘焙", origin: "哥倫比亞", flavor: "核桃  西瓜", picture: UIImage(named: "KoffeeKult")!, process: "日曬  重焙", quote: "像淡淡的蜂蜜，喝得到陽光下花朵的味道。", rates: CoffeeBeanRate(aftertaste: 3, acidity: 1, sweet: 3, aroma: 4, body: 1), parameters: CoffeeBeanParameter(weight: 30, capacity: 300, temperature: 92, timeMinute: 02, timeSecond: 30))
        case 3:
            return CoffeeBean(name: "尼泊爾超重焙", origin: "尼泊爾", flavor: "威士忌  香草", picture: UIImage(named: "Aromistico")!, process: "日曬  重焙", quote: "像淡淡的蜂蜜，喝得到陽光下花朵的味道。", rates: CoffeeBeanRate(aftertaste: 3, acidity: 4, sweet: 3, aroma: 4, body: 2), parameters: CoffeeBeanParameter(weight: 30, capacity: 300, temperature: 92, timeMinute: 02, timeSecond: 30))
        case 4:
            return CoffeeBean(name: "皇家級中等烘焙", origin: "瓜地馬拉", flavor: "草莓  桃子  鳳梨", picture: UIImage(named: "MediumRoast")!, process: "日曬  中焙", quote: "像淡淡的蜂蜜，喝得到陽光下花朵的味道。", rates: CoffeeBeanRate(aftertaste: 3, acidity: 4, sweet: 3, aroma: 4, body: 2), parameters: CoffeeBeanParameter(weight: 30, capacity: 300, temperature: 92, timeMinute: 02, timeSecond: 30))
        default:
            return CoffeeBean(name: "耶加雪啡", origin: "衣索比雅", flavor: "草莓  桃子  鳳梨", picture: UIImage(named: "BreackfastBlend")!, process: "日曬  淺焙", quote: "像淡淡的蜂蜜，喝得到陽光下花朵的味道。", rates: CoffeeBeanRate(aftertaste: 3, acidity: 4, sweet: 3, aroma: 4, body: 2), parameters: CoffeeBeanParameter(weight: 30, capacity: 300, temperature: 92, timeMinute: 02, timeSecond: 30))
        }
    }
}
