//
//  String+Extensions.swift
//  
//
//  Created by Noah Little on 13/5/2023.
//

import Foundation

extension String {
    var nilIfEmpty: Self? {
        isEmpty ? nil : self
    }
}
