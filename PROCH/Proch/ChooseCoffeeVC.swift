//
//  ChooseCoffeeVC.swift
//  PROCH
//
//  Created by CdxN on 2017/8/14.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import UIKit
import ApiAI

enum CoffeeStandard {
    case espresso
    case mocha
    case latte
    case flatWhite
    case espressoConPanna
    case espressoMacchiato
    case cappucino
    case breve
    case americano
}

class ChooseCoffeeVC: UIViewController,UITextFieldDelegate, iCarouselDelegate, iCarouselDataSource, ApiAIManagerDelegate {

    let myVcType = "chooseCoffee"
    var response: ApiAIResponse!
    var apiAIResponseManager = ApiAIManager()

    @IBOutlet var orderBtn: UIButton!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var carouselView: iCarousel!
    @IBOutlet var descriptionLabel: UILabel!

    var numbers = [Int]()
    var imageArray = [UIImage]()
    var nameArray = [String]()
    var coffeeDescriptions = [String]()
    var choosedCoffee = CoffeeStandard.espresso

    override func awakeFromNib() {
        super.awakeFromNib()

        apiAIResponseManager.delegate = self

        numbers = [1, 2, 3, 4, 5, 6]
        imageArray = [#imageLiteral(resourceName: "Espresso"), #imageLiteral(resourceName: "Mocha"), #imageLiteral(resourceName: "Latte"), #imageLiteral(resourceName: "FlatWhite"), #imageLiteral(resourceName: "EspressoConPanna"), #imageLiteral(resourceName: "EspressoMacchiato"), #imageLiteral(resourceName: "Americano"), #imageLiteral(resourceName: "Cappucino"), #imageLiteral(resourceName: "Breve")]
        nameArray = ["Espresso", "Mocha", "Latte", "FlatWhite", "EspressoConPanna", "EspressoMacchiato", "Americano", "Cappucino", "Breve"]
        coffeeDescriptions = [
            "一般比其他方法製作出來的咖啡更加濃厚，含有更高濃度的懸浮物和已溶解固體，如表層的咖啡脂（一種奶油質地的泡沫）。因為其加壓的製作過程，espresso口味強烈，其中的化學物質濃度非常高。",
            "摩卡是義式拿鐵咖啡的變種。和經典的義式拿鐵咖啡一樣，它通常是由三分之一的義式濃縮咖啡和三分之二的奶沫配成，不過它還會加入少量巧克力。",
            "拿鐵咖啡一詞才在義大利境外使用。一般的拿鐵咖啡的成分是三分之一的濃縮咖啡加三分之二的鮮奶，一般不加入奶泡。",
            "同於馬來西亞當地的黑咖啡的製法，白咖啡的咖啡豆在經過棕櫚油烘培的過程當中不添加糖和小麥，同時使用低溫烘培法，烘培時間較一般咖啡長,每豆咖啡因含量較低。",
            "在義大利文中的意思是「帶奶油的濃縮咖啡」。顧名思義，濃縮康保藍是一種頂層覆蓋著厚厚奶油的濃縮咖啡，有單份量，也有雙份量。",
            "是一種使用少量牛奶或奶泡加上濃縮咖啡製作而成的咖啡飲料。瑪奇雅朵（義大利語：macchiato）的意思是「標記」、「烙印」或「染色」，因此瑪琪雅朵咖啡的字面意思是以牛奶來上色的濃縮咖啡。",
            "美式咖啡源自於戰爭時期在歐洲的美軍將熱水混進歐洲常見的小份濃縮咖啡的習慣。因為一般說來，美國人對咖啡的製作較為隨意且簡單，這種方法便很快地隨著美國連鎖店在世界上的普及而流行開來。",
            "卡布奇諾咖啡的顏色，就像方濟嘉布遣會（拉丁語：Ordo Fratrum Minorum Capuccinorum）的修士的深褐色的長袍一樣，卡布奇諾咖啡因此得名。",
            "布雷衛的口感和拿鐵相似，也有人稱為「半拿鐵」。比例與口感與拿鐵非常類似，但 Breve 的牛奶混合著鮮奶油蒸煮，更為濃密的奶泡會讓人誤以為是在品嚐甜點。"]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        carouselView.type = .cylinder
        carouselView.backgroundColor = UIColor.clear
        self.hideKeyboardWhenTappedAround()
        titleTextField.delegate = self
        setNavigaitonFontsAndColor()
        descriptionLabel.setLineHeight(lineHeight: 20.0)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        //        textField.placeholder = textField.text
        if let text = self.titleTextField.text, text != "" {
            queryProch(query: text)
        } else { }
        
        return true
    }

    func numberOfItems(in carousel: iCarousel) -> Int {
        return imageArray.count
    }

    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let tempView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))

        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        button.setImage(imageArray[index], for: .normal)
        button.backgroundColor = UIColor.white
        button.tag = index
        button.addTarget(self, action: #selector(self.handleTap(sender:)), for: .touchUpInside)
        tempView.backgroundColor = UIColor.clear

        tempView.addSubview(button)

        titleTextField.text = ""
        titleTextField.textColor = UIColor.black
        titleTextField.attributedPlaceholder = NSAttributedString(string: nameArray[index], attributes: [NSForegroundColorAttributeName: UIColor.Proch.Green.ProchGreen])
        descriptionLabel.text = coffeeDescriptions[index]

        return tempView
    }

    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        print("gogogogogo")

        choosedCoffee = choosedCoffeeIs(selected: nameArray[index])

        self.performSegue(withIdentifier: "toCoffeeDetail", sender: self)
    }

    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == iCarouselOption.spacing {

            return value * 1
        }

        return value
    }

    func carouselDidEndScrollingAnimation(_ carousel: iCarousel) {
        titleTextField.attributedPlaceholder = NSAttributedString(string: nameArray[carouselView.currentItemIndex], attributes: [NSForegroundColorAttributeName: UIColor.Proch.Green.ProchGreen])
        descriptionLabel.text = coffeeDescriptions[carouselView.currentItemIndex]
        orderBtn.setTitle("來一杯\(nameArray[carouselView.currentItemIndex])!", for: .normal)
        choosedCoffee = choosedCoffeeIs(selected: nameArray[carouselView.currentItemIndex])
    }

    func queryProch(query: String) {
        self.titleTextField.text?.removeAll()

        apiAIResponseManager.requestBotResponse(query: query)
    }

    func manager(_ manager: ApiAIManager, didGet response: ApiAIResponse) {
        self.response = response

        self.switchVC(vcType: self.response.vcType, currentVcType: self.myVcType)

        globalResponse = self.response
    }

    func manager(_ manager: ApiAIManager, didFailWith error: Error) {
        print("Do not Get Response From ApiAI")
    }

    func handleTap(sender: UIButton) {
        print("handleTap - gogogogogo")
        choosedCoffee = choosedCoffeeIs(selected: nameArray[sender.tag])
        self.performSegue(withIdentifier: "toCoffeeDetail", sender: self)
    }

    @IBAction func orderCoffee(_ sender: Any) {
    
        var queryString = String()
        
        switch choosedCoffee {
            
        case .americano:
            queryString = "美式咖啡"
        case .breve:
            queryString = "布雷衛"
        case .cappucino:
            queryString = "卡布奇諾"
        case .espresso:
            queryString = "義式濃縮"
        case .espressoConPanna:
            queryString = "濃縮康保藍"
        case .espressoMacchiato:
            queryString = "瑪琪雅朵"
        case .flatWhite:
            queryString = "白咖啡"
        case .latte:
            queryString = "拿鐵"
        case .mocha:
            queryString = "摩卡"
        }

        queryProch(query: queryString)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? CoffeeDetailVC {
            destinationVC.choosedCoffee = self.choosedCoffee
        }
    }
    
    func choosedCoffeeIs(selected: String) -> CoffeeStandard {
        
        print("Selected is \(selected)")

        switch selected {
        case "Americano":
            return CoffeeStandard.americano
        case "Breve":
            return CoffeeStandard.breve
        case "Cappucino":
            return CoffeeStandard.cappucino
        case "Espresso":
            return CoffeeStandard.espresso
        case "EspressoConPanna":
            return CoffeeStandard.espressoConPanna
        case "EspressoMacchiato":
            return CoffeeStandard.espressoMacchiato
        case "FlatWhite":
            return CoffeeStandard.flatWhite
        case "Latte":
            return CoffeeStandard.latte
        case "Mocha":
            return CoffeeStandard.mocha
        default:
            print("choosedCoffee went wrong")
        }
        return CoffeeStandard.cappucino
    }
}
