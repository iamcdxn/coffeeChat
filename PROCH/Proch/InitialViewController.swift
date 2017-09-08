//
//  InitialViewController.swift
//  PROCH
//
//  Created by CdxN on 2017/8/18.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import UIKit
import ApiAI

class InitialVC: UIViewController, ApiAIManagerDelegate {

    let myVcType = "initialPage"
    var response: ApiAIResponse!
    var apiAIResponseManager = ApiAIManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        apiAIResponseManager.delegate = self
        queryProch(query: "早安")
        printFontNames()
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
    
    // Print Font Name If Needed
    func printFontNames() {
        for family: String in UIFont.familyNames
        {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
    }

}
