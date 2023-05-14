//
//  Settings+Types.swift
//
//
//  Created by Noah Little on 7/4/2023.
//

import SwiftUI

extension Settings {
    struct StatusBar {
        let isEnabled: Bool
        let isEnabledAMPM: Bool
    }
    
    struct LockScreen {
        let isEnabled: Bool
        let colorMode: ColorMode
        let primaryClockAppearance: ClockAppearance
        let secondaryClockAppearance: ClockAppearance
        let timeTemplate: DateTemplate
        let dateTemplate: DateTemplate
        let showSeconds: Bool
        let selectedFont: FontType
        let secondsColor: UIColor
        let verticalOffset: Double
        let isSingleDate: Bool
    }
    
    struct ClockAppearance {
        let nameColor: UIColor
        let timeColor: UIColor
        let dateColor: UIColor
    }
    
    struct ClockInfo: Identifiable {
        let isPrimary: Bool
        let timeZone: TimeZone
        let locale: Locale
        let name: String?
        
        var id: String {
            timeZone.identifier + locale.identifier
        }
    }
    
    enum ColorMode: Int {
        case adaptive
        case custom
    }
    
    enum FontType: Int {
        case `default`
        case monospaced
        case rounded
        case serif
        
        var representedFont: Font.Design {
            switch self {
            case .default: return .default
            case .rounded: return .rounded
            case .monospaced: return .monospaced
            case .serif: return .serif
            }
        }
    }
}
