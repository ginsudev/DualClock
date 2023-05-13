//
//  LocalState.swift
//  
//
//  Created by Noah Little on 7/5/2023.
//

import UIKit

final class LocalState: ObservableObject {
    static let shared = LocalState()
    
    @Published var wallpaperSuitableForegroundColor: UIColor?
    
    private init() { }
}
