//
//  UIColor+extensions.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 22/01/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    // custom color methods converst hex value to rgb value
    class private func colourWithHex(rgbValue: UInt32) -> UIColor {
        return UIColor( red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                        alpha: CGFloat(1.0))
    }
    class private func colourWithHexString(hexStr: String) -> UIColor {
        var cString:String = hexStr.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (hexStr.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if (cString.isEmpty || (cString.count) != 6) {
            return colourWithHex(rgbValue: 0xFF5300);
        } else {
            var rgbValue:UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            return colourWithHex(rgbValue: rgbValue);
        }
    }
    //Custom colours
    struct Reds {
        static let standardRed = UIColor.colourWithHexString(hexStr: "#FF0000")
    }
    struct Blues {
        static let standardBlue = UIColor.colourWithHexString(hexStr: "#0000FF")
        static let lightBlue = UIColor.colourWithHexString(hexStr: "#6FA0CD")
        static let softBlue = UIColor.colourWithHexString(hexStr: "#6FBDCD")
    }
    struct Yellows {
        static let standardYellow = UIColor.colourWithHexString(hexStr: "#FFFF00")
        
    }
    struct Purples {
        static let standardPurple = UIColor.colourWithHexString(hexStr: "#800080")
    }
    struct Oranges {
        static let standardOrange = UIColor.colourWithHexString(hexStr: "#FFA500")
    }
    struct  Greens {
        static let standardGreen = UIColor.colourWithHexString(hexStr: "#00FF00")
        static let seaGreen = UIColor.colourWithHexString(hexStr: "#2E8B57")
    }
    struct Shades {
        static let standardGrey = UIColor.colourWithHexString(hexStr: "#808080")
        static let standardBlack = UIColor.colourWithHexString(hexStr: "#000000")
        static let standardWhite = UIColor.colourWithHexString(hexStr: "#FFFFFF")
    }
}

