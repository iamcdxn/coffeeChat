//
//  ApiAIManager.swift
//  PROCH
//
//  Created by CdxN on 2017/8/17.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import Foundation
import ApiAI

protocol ApiAIManagerDelegate: class {
    func manager(_ manager: ApiAIManager, didGet response: ApiAIResponse)
    
    func manager(_ manager: ApiAIManager, didFailWith error: Error)
}

class ApiAIManager {
    weak var delegate: ApiAIManagerDelegate?

    
    func requestBotResponse(query: String) {

        var btnTitles = [String]()
        var titles = [String]()
        var vcType = String()

        let request = ApiAI.shared().textRequest()
        request?.query = query

        request?.setMappedCompletionBlockSuccess({ (request, response) in
            let response = response as? AIResponse
            print(response?.result.action ?? "No response Action")
            
            if let textresponse = response?.result.fulfillment.messages as? [[String: Any]] {
                for fbQuickreplies in textresponse {
                    var platform = String()
                    if let replies: NSArray = fbQuickreplies["replies"] as? NSArray {
                        if let btnArray = replies as? [String] {
                            btnTitles = btnArray
                        }
                    }
                    if let response: String = fbQuickreplies["platform"] as? String {
                        platform = response
                    }
                    if let response: String = fbQuickreplies["speech"] as? String {
                        if platform != "facebook" {
                            let botResponseMessenge = response
                            let splitedArray = botResponseMessenge.components(separatedBy: "loso")
                            if splitedArray.count > 1 {
                                titles = splitedArray
                            } else {
                                titles.append(botResponseMessenge)
                            }
                            print("Response is \(response)")
                        }
                    }
                    if let payload = fbQuickreplies["payload"] as? [String:Any] {
                        if let proch = payload["proch"] as? [String:Any] {
                            if let storyboardType = proch["storyboard"] as? String {
                                print("vcType: \(storyboardType)")
                                vcType = storyboardType
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.delegate?.manager(self, didGet: ApiAIResponse(btnTitles: btnTitles, titles: titles, vcType: vcType))
                    }
                }
            }
        }, failure: { (resuest, error) in
            print(error ?? "Sth went wrong QQQQQQQQ")
        })
        ApiAI.shared().enqueue(request)
    }
}
