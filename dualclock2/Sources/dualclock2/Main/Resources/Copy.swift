//
//  Copy.swift
//  
//
//  Created by Noah Little on 6/5/2023.
//

import Foundation
import GSCore

enum Copy {
    static let twentyFourHourMode = "TWENTY_FOUR_HOUR_MODE".localize(bundle: .dualClock)
    static let customTimeZone = "CUSTOM_TIME_ZONE".localize(bundle: .dualClock)
    static let clocks = "CLOCKS".localize(bundle: .dualClock)
    static let timeZone = "TIMEZONE".localize(bundle: .dualClock)
    static let locale = "LOCALE".localize(bundle: .dualClock)
    static let nameColon = "NAME_COLON".localize(bundle: .dualClock)
    static let primary = "PRIMARY".localize(bundle: .dualClock)
    static let secondary = "SECONDARY".localize(bundle: .dualClock)
    static let misc = "MISC".localize(bundle: .dualClock)
    static let preview = "PREVIEW".localize(bundle: .dualClock)
    static let showSeconds = "SHOW_SECONDS".localize(bundle: .dualClock)
    static let enabled = "ENABLED".localize(bundle: .dualClock)
    static let lockScreen = "LOCK_SCREEN".localize(bundle: .dualClock)
    static let verticalOffset = "VERTICAL_OFFSET".localize(bundle: .dualClock)
    static let moveDualClockUpDown = "MOVE_DUALCLOCK_UP_DOWN".localize(bundle: .dualClock)
    static let colorMode = "COLOR_MODE".localize(bundle: .dualClock)
    static let colors = "COLORS".localize(bundle: .dualClock)
    static let adaptiveColorDesc = "ADAPTIVE_COLOR_DESC".localize(bundle: .dualClock)
    static let name = "NAME".localize(bundle: .dualClock)
    static let time = "TIME".localize(bundle: .dualClock)
    static let date = "DATE".localize(bundle: .dualClock)
    static let seconds = "SECONDS".localize(bundle: .dualClock)
    static let `default` = "DEFAULT".localize(bundle: .dualClock)
    static let custom = "CUSTOM".localize(bundle: .dualClock)
    static let monospaced = "MONOSPACED".localize(bundle: .dualClock)
    static let rounded = "ROUNDED".localize(bundle: .dualClock)
    static let serif = "SERIF".localize(bundle: .dualClock)
    static let timeFormat = "TIME_FORMAT".localize(bundle: .dualClock)
    static let timeFormatting = "TIME_FORMATTING".localize(bundle: .dualClock)
    static let dateFormat = "DATE_FORMAT".localize(bundle: .dualClock)
    static let dateFormatting = "DATE_FORMATTING".localize(bundle: .dualClock)
    static let font = "FONT".localize(bundle: .dualClock)
    static let fonts = "FONTS".localize(bundle: .dualClock)
    static let adaptive = "ADAPTIVE".localize(bundle: .dualClock)
    static let showAMPM = "SHOW_AM_PM".localize(bundle: .dualClock)
    static let statusBar = "STATUS_BAR".localize(bundle: .dualClock)
    static let setupClocks = "SETUP_CLOCKS".localize(bundle: .dualClock)
    static let configureLS = "CONFIGURE_LS".localize(bundle: .dualClock)
    static let configureSB = "CONFIGURE_SB".localize(bundle: .dualClock)
    static let singleDate = "SINGLE_DATE".localize(bundle: .dualClock)
    static let singleDateDesc = "SINGLE_DATE_DESC".localize(bundle: .dualClock)
    
    
    
    static func color(_ string: String) -> String {
        String(
            format: "COLOR".localize(bundle: .dualClock),
            string
        )
    }
}
