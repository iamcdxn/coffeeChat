//
//  dismissKeyboardWhenTappedAround.swift
//  PROCH
//
//  Created by CdxN on 2017/8/16.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import Foundation

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
