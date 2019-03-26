//
//  UIButton+extensions.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 13/03/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func centerTextHorizontally(spacing: CGFloat) {
        //adds spacing/padding to thew left and right
        titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        //centers text
        self.titleLabel?.textAlignment = NSTextAlignment.center
    }
}




