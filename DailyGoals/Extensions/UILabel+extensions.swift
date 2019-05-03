//
//  UILabel+extensions.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 26/03/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func titleLabelFormat(colour: UIColor) {
        self.font = UIFont(name: "TrebuchetMS", size: 45.0)?.bold().italic()
        self.textAlignment = .center
        self.textColor = colour
    }
}
