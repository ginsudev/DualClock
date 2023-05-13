//
//  Bundle+DualClock.swift
//  
//
//  Created by Noah Little on 6/5/2023.
//

import Foundation
import GSCore

extension Bundle {
    static var dualClock: Bundle {
        if let bundle = Bundle(path: "/Library/PreferenceBundles/dualclock2.bundle/".rootify) {
            return bundle
        } else {
            return .main
        }
    }
}
