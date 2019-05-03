//
//  UIFont+extensions.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 26/03/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    func withTraits(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        let descriptor = self.fontDescriptor
            .withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits).union(self.fontDescriptor.symbolicTraits))
        return UIFont(descriptor: descriptor!, size: 0)
    }
    func withoutTraits(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        let descriptor = self.fontDescriptor
            .withSymbolicTraits(  self.fontDescriptor.symbolicTraits.subtracting(UIFontDescriptor.SymbolicTraits(traits)))
        return UIFont(descriptor: descriptor!, size: 0)
    }

    func bold() -> UIFont {
        return withTraits( .traitBold)
    }

    func italic() -> UIFont {
        return withTraits(.traitItalic)
    }

    func noItalic() -> UIFont {
        return withoutTraits(.traitItalic)
    }
    func noBold() -> UIFont {
        return withoutTraits(.traitBold)
    }
}
