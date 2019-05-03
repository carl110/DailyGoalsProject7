//
//  UIView+extensions.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 13/03/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    //round corners of a view, individually or all together
    func roundCorners(for corners: UIRectCorner, cornerRadius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    func setRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    //Find viewcontroller of current view ie custom table etc
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
    
    //animates view to grow
    func customAnimtation() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 100.0, y: 100.0)
        }, completion: { (finished: Bool) in
            self.fadeOut()
        } )
    }
    
    func fadeOut(_ duration: TimeInterval = 0.5, delay: TimeInterval = 0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveLinear, animations: { [weak self] in
            self?.alpha = 0.0
            }, completion: { (finished: Bool) in
                self.removeFromSuperview()
        } )
    }

    func fadeIn(_ duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveLinear, animations: { [weak self] in
            self?.alpha = 1.0
            }, completion: completion)
    }
}
