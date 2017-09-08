//
//  SeriesProductModel.swift
//  PROCH
//
//  Created by CdxN on 2017/8/15.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import Foundation

struct SeriesProduct {
    let name: String
    let picture: UIImage
    let price: Int
}

struct CoffeeBean {
    let name: String
    let origin: String
    let flavor: String
    let picture: UIImage
    let process: String
    let quote: String
    let rates: CoffeeBeanRate
    let parameters: CoffeeBeanParameter
}

struct CoffeeBeanRate {
    let aftertaste: Float
    let acidity: Float
    let sweet: Float
    let aroma: Float
    let body: Float
}

struct CoffeeBeanParameter {
    let weight: Int
    let capacity: Int
    let temperature: Float
    let timeMinute: Int
    let timeSecond: Int
}
