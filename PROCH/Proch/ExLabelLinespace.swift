//
//  ExLabelLinespace.swift
//  PROCH
//
//  Created by CdxN on 2017/8/18.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import Foundation

extension UILabel
{
    func setLineHeight(lineHeight: CGFloat)
    {
        let text = self.text
        if let text = text
        {
            
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            
            style.lineSpacing = lineHeight
            attributeString.addAttribute(NSParagraphStyleAttributeName,
                                         value: style,
                                         range: NSMakeRange(0, text.characters.count))
            
            self.attributedText = attributeString
        }
    }
}
