//
//  HomeVC.swift
//  PROCH
//
//  Created by CdxN on 2017/8/11.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import UIKit
import ApiAI

var globalResponse: ApiAIResponse!

class HomeVC: UIViewController,UITextFieldDelegate, ApiAIManagerDelegate {

    let myVcType = "homepage"
    var response: ApiAIResponse!
    var apiAIResponseManager = ApiAIManager()

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var subtitleLabel: UILabel!
    var btns: [UIButton]!

    @IBOutlet var btn0: UIButton!
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var btn3: UIButton!
    @IBOutlet var btn4: UIButton!
    @IBOutlet var micBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigaitonFontsAndColor()

        apiAIResponseManager.delegate = self

        btns = [btn0, btn1, btn2, btn3, btn4]
        for btn in btns {
            btn.isHidden = true
        }

        self.titleTextField.delegate = self
        self.hideKeyboardWhenTappedAround()

        titleTextField.text?.removeAll()
        titleTextField.textColor = UIColor.black

        if globalResponse.titles.count >= 1 {
            titleTextField.attributedPlaceholder = NSAttributedString(string: globalResponse.titles[0], attributes: [NSForegroundColorAttributeName: UIColor.Proch.Green.ProchGreen])
        }

        if globalResponse.titles.count >= 2 {
            subtitleLabel.text = globalResponse.titles[1]
        }

        setBtnTitle(sender: globalResponse.btnTitles)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        //        textField.placeholder = textField.text
        if let text = self.titleTextField.text, text != "" {
            queryProch(query: text)
        } else { }

        return true
    }

    func queryProch(query: String) {
        self.clearBtnTitle()
        //        self.speeches.removeAll()
        self.titleTextField.text?.removeAll()
        self.subtitleLabel.text?.removeAll()
        
        apiAIResponseManager.requestBotResponse(query: query)
    }

    func manager(_ manager: ApiAIManager, didGet response: ApiAIResponse) {
        self.response = response

        self.switchVC(vcType: self.response.vcType, currentVcType: self.myVcType)

        self.setBtnTitle(sender: self.response.btnTitles)

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

    func clearBtnTitle() {
        for a in 0...4 {
            UIView.animate(withDuration: 0.2, animations: {
                self.btns[a].alpha = 0.0
            }, completion: { (true) in
                self.btns[a].isHidden = true
                print("Btn 💣")
            })
        }
    }

    func setBtnTitle(sender: [String]) {

        print("Btns: \(sender)")

        var i = 4
        for text in sender {
            self.btns[i].setTitle(text, for: .normal)

            UIView.animate(withDuration: 1.0, animations: {
                self.btns[i].alpha = 1.0
                self.btns[i].isHidden = false
                print("Btn 💡")
            })

            i -= 1
        }

    }

    @IBAction func pressBtn0(_ sender: Any) {
        if let text = self.btn0.titleLabel?.text {
            queryProch(query: text)
        }
    }

    @IBAction func pressBtn1(_ sender: Any) {
        if let text = self.btn1.titleLabel?.text {
            queryProch(query: text)
        }
    }

    @IBAction func pressBtn2(_ sender: Any) {
        if let text = self.btn2.titleLabel?.text {
            queryProch(query: text)
        }
    }

    @IBAction func pressBtn3(_ sender: Any) {
        if let text = self.btn3.titleLabel?.text {
            queryProch(query: text)
        }
    }

    @IBAction func pressBtn4(_ sender: Any) {
        if let text = self.btn4.titleLabel?.text {
            queryProch(query: text)
        }
    }

}
