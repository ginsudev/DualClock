//
//  TimeZone+Extensions.swift
//  
//
//  Created by Noah Little on 13/5/2023.
//

import Foundation

extension TimeZone {
    var placeName: String {
        (identifier.components(separatedBy: "/").last ?? "Local")
            .replacingOccurrences(of: "_", with: " ")
    }
    
    var icon: String {
        self.identifier == TimeZone.autoupdatingCurrent.identifier
        ? "house.fill"
        : "location.fill"
    }
}
