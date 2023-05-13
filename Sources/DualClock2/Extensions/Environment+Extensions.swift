//
//  Environment+Extensions.swift
//  
//
//  Created by Noah Little on 7/5/2023.
//

import SwiftUI

private struct FontDesignKey: EnvironmentKey {
    static let defaultValue: Font.Design = .default
}

private struct LandscapeVisibilityKey: EnvironmentKey {
    static let defaultValue = false
}

extension EnvironmentValues {
    var fontDesign: Font.Design {
        get { self[FontDesignKey.self] }
        set { self[FontDesignKey.self] = newValue }
    }
    
    var isLandscape: Bool {
        get { self[LandscapeVisibilityKey.self] }
        set { self[LandscapeVisibilityKey.self] = newValue }
    }
}
