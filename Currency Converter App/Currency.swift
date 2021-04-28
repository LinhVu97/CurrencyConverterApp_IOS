//
//  Currency.swift
//  Currency Converter App
//
//  Created by Vũ Linh on 28/04/2021.
//

import Foundation

struct Currency {
    var code: String
    var value: Double = 0
    var image: String {
        return code + ".png"
    }
}
