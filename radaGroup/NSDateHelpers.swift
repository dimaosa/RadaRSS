//
//  NSDateHelpers.swift
//  radaGroup
//
//  Created by Osadchy Dima on 4/15/16.
//  Copyright © 2016 Osadchy Dima. All rights reserved.
//

import Foundation

extension NSDate {
    func dateStringWithFormat(format: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.stringFromDate(self)
    }
}