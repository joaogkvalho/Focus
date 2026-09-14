//
//  Colors.swift
//  focus
//
//  Created by Joao Gabriel Carvalho on 31/08/26.
//

import Foundation
import UIKit

enum Colors {
    static let background = UIColor(hex: "#FAFAFA")
    static let grayBase = UIColor(hex: "#1E1E1E")
    static let grayLight = UIColor(hex: "#EBEBEB")
}

extension UIColor {
    convenience init(hex: String) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        hexFormatted = hexFormatted.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
