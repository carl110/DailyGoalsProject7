//
//  UITableView + extensions.swift
//  DailyGoals
//
//  Created by Carl Wainwright on 11/02/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    //return number of rows in given section
    func indexPathsForRowsInSection(_ section: Int) -> [NSIndexPath] {
        return (0..<self.numberOfRows(inSection: section)).map { NSIndexPath(row: $0, section: section) }
    }
}
