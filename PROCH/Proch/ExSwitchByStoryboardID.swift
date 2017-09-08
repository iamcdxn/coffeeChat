//
//  ExSwitchByStoryboardID.swift
//  PROCH
//
//  Created by CdxN on 2017/8/16.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import Foundation

extension UIViewController {

    func switchVC(vcType: String, currentVcType: String) {

        var storyboardId = String()
        
        switch vcType {
        case "home":
            storyboardId = "homepage"
        case "makingCoffee":
            storyboardId = "makingCoffee"
        case "chooseCoffee":
            storyboardId = "chooseCoffee"
        default:
            storyboardId = "homepage"
            print("DEEEEEEEEEEFAULT ID")
        }
        
        if storyboardId == currentVcType {
            print("Same VC Type")
            return
        } else {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let secondVC = storyboard.instantiateViewController(withIdentifier: storyboardId)
            secondVC.modalPresentationStyle = UIModalPresentationStyle.custom
            secondVC.modalTransitionStyle = .crossDissolve
            self.present(secondVC, animated: true, completion: nil)
            print("================= Switching =================")
            return
        }
    }
}
