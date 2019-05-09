//
//  String+extension.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 01/05/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

extension String {
    //Convert text to title case "This Is Title Case"
    func titlecased() -> String {
        return self.replacingOccurrences(of: "([A-Z])", with: " $1", options: .regularExpression, range: self.range(of: self))
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .capitalized
    }
    
    //sets first letter of string to capital
    var uppercasingFirst: String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    //sets first character of string to lower case
    var lowercasingFirst: String {
        return prefix(1).lowercased() + dropFirst()
    }
    
    //convers string to camelCase
    var camelCase: String {
        guard !isEmpty else {
            return ""
        }
        
        //split individual words to sections
        let parts = self.components(separatedBy: CharacterSet.alphanumerics.inverted)
        
        //set first section with lowercase and rest with capital as first character
        let first = String(describing: parts.first!).lowercasingFirst
        let rest = parts.dropFirst().map({String($0).uppercasingFirst})
        
        return ([first] + rest).joined(separator: "")
    }
}
