//
//  SetNCFont.swift
//  PROCH
//
//  Created by CdxN on 2017/8/19.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import Foundation

extension UIViewController {
    //Setting Navigation Bar
    func setNavigaitonFontsAndColor() {
        self.navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont(name: "PingFangHK-Regular", size: 18)!, NSKernAttributeName: 20.0]
    }

}
