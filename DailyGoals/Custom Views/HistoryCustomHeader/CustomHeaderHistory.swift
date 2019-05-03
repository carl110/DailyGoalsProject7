//
//  CustomHeaderHistory.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 26/04/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class CustomHeaderHistory: UITableViewHeaderFooterView {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    
    func config() {

        labelTitle.tintColor = UIColor.clear

                labelTitle.numberOfLines = 0
        labelTitle.lineBreakMode = NSLineBreakMode.byWordWrapping
        labelTitle.textColor = UIColor.Shades.standardWhite
        background.backgroundColor = UIColor.Blues.lightBlue
    }
    
    override func prepareForReuse() {
        labelTitle.text = ""
    }
}

