//
//  CoffeeDetailVC.swift
//  PROCH
//
//  Created by CdxN on 2017/8/17.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import UIKit

class CoffeeDetailVC: UIViewController, ApiAIManagerDelegate {

    let myVcType = "coffeeDetail"
    var response: ApiAIResponse!
    var apiAIResponseManager = ApiAIManager()

    @IBOutlet var coffeeName: UILabel!
    @IBOutlet var coffeeSubtitle: UILabel!
    @IBOutlet var coffeeDescription: UILabel!
    @IBOutlet var coffeePic: UIImageView!
    @IBOutlet var coffeeGradient: UILabel!
    var choosedCoffee = CoffeeStandard.americano

    override func viewDidLoad() {
        super.viewDidLoad()

        apiAIResponseManager.delegate = self

        switch choosedCoffee {
        case .americano:
            self.title = "美式咖啡"
            coffeeName.text = "美式咖啡"
            coffeePic.image = UIImage(named: "Americano")
            coffeeDescription.text = "美式咖啡源自於戰爭時期在歐洲的美軍將熱水混進歐洲常見的小份濃縮咖啡的習慣。因為一般說來，美國人對咖啡的製作較為隨意且簡單，這種方法便很快地隨著美國連鎖店在世界上的普及而流行開來。"

        case .breve:
            self.title = "布雷衛"
            coffeeName.text = "布雷衛"
            coffeePic.image = UIImage(named: "Breve")
            coffeeDescription.text = "布雷衛的口感和拿鐵相似，也有人稱為「半拿鐵」。比例與口感與拿鐵非常類似，但 Breve 的牛奶混合著鮮奶油蒸煮，更為濃密的奶泡會讓人誤以為是在品嚐甜點。"

        case .cappucino:
            self.title = "卡布奇諾"
            coffeeName.text = "卡布奇諾"
            coffeePic.image = UIImage(named: "Cappucino")
            coffeeDescription.text = "卡布奇諾咖啡的顏色，就像方濟嘉布遣會（拉丁語：Ordo Fratrum Minorum Capuccinorum）的修士的深褐色的長袍一樣，卡布奇諾咖啡因此得名。"

        case .espresso:
            self.title = "濃縮咖啡"
            coffeeName.text = "濃縮咖啡"
            coffeePic.image = UIImage(named: "Espresso")
            coffeeDescription.text = "一般比其他方法製作出來的咖啡更加濃厚，含有更高濃度的懸浮物和已溶解固體，如表層的咖啡脂（一種奶油質地的泡沫）。因為其加壓的製作過程，espresso口味強烈，其中的化學物質濃度非常高。"

        case .espressoConPanna:
            self.title = "濃縮康保藍"
            coffeeName.text = "濃縮康保藍"
            coffeePic.image = UIImage(named: "EspressoConPanna")
            coffeeDescription.text = "在義大利文中的意思是「帶奶油的濃縮咖啡」。顧名思義，濃縮康保藍是一種頂層覆蓋著厚厚奶油的濃縮咖啡，有單份量，也有雙份量。"

        case .espressoMacchiato:
            self.title = "瑪琪雅朵"
            coffeeName.text = "瑪琪雅朵"
            coffeePic.image = UIImage(named: "EspressoMacchiato")
            coffeeDescription.text = "是一種使用少量牛奶或奶泡加上濃縮咖啡製作而成的咖啡飲料。瑪奇雅朵（義大利語：macchiato）的意思是「標記」、「烙印」或「染色」，因此瑪琪雅朵咖啡的字面意思是以牛奶來上色的濃縮咖啡。"

        case .flatWhite:
            self.title = "白咖啡"
            coffeeName.text = "白咖啡"
            coffeePic.image = UIImage(named: "FlatWhite")
            coffeeDescription.text = "同於馬來西亞當地的黑咖啡的製法，白咖啡的咖啡豆在經過棕櫚油烘培的過程當中不添加糖和小麥，同時使用低溫烘培法，烘培時間較一般咖啡長,每豆咖啡因含量較低。"

        case .latte:
            self.title = "拿鐵咖啡"
            coffeeName.text = "拿鐵咖啡"
            coffeePic.image = UIImage(named: "Latte")
            coffeeDescription.text = "拿鐵咖啡一詞才在義大利境外使用。一般的拿鐵咖啡的成分是三分之一的濃縮咖啡加三分之二的鮮奶，一般不加入奶泡。"

        case .mocha:
            self.title = "摩卡咖啡"
            coffeeName.text = "摩卡咖啡"
            coffeePic.image = UIImage(named: "Mocha")
            coffeeDescription.text = "摩卡是義式拿鐵咖啡的變種。和經典的義式拿鐵咖啡一樣，它通常是由三分之一的義式濃縮咖啡和三分之二的奶沫配成，不過它還會加入少量巧克力。"

        }

        coffeePic.contentMode = .scaleAspectFit
        coffeePic.backgroundColor = UIColor.clear
        coffeeDescription.setLineHeight(lineHeight: 10.0)
        coffeeGradient.setLineHeight(lineHeight: 12.0)
        coffeeGradient.textAlignment = .right

    }

    func queryProch(query: String) {

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
            queryString = "濃縮咖啡"
        case .espressoConPanna:
            queryString = "康寶藍"
        case .espressoMacchiato:
            queryString = "焦糖瑪奇朵"
        case .flatWhite:
            queryString = "白咖啡"
        case .latte:
           queryString = "拿鐵"
        case .mocha:
            queryString = "摩卡"
        }
        queryProch(query: queryString)
    }
}
