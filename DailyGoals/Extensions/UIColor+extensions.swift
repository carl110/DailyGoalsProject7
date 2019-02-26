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
    
    // custom color methods
    class func colorWithHex(rgbValue: UInt32) -> UIColor {
        return UIColor( red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                        alpha: CGFloat(1.0))
    }
    
    class func colorWithHexString(hexStr: String) -> UIColor {
        var cString:String = hexStr.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (hexStr.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if (cString.isEmpty || (cString.count) != 6) {
            return colorWithHex(rgbValue: 0xFF5300);
        } else {
            var rgbValue:UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            
            return colorWithHex(rgbValue: rgbValue);
        }
    }
    
    struct CustomColour {
        struct Blue {
            static let lightBlue = UIColor.colorWithHexString(hexStr: "#6FA0CD")
            static let softBlue = UIColor.colorWithHexString(hexStr: "#6FBDCD")
            static let 

//        struct  Green {
//            static let newGreen = 
//        }

    }
}
}
