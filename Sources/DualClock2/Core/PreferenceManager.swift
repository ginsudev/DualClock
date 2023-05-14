//
//  PreferenceManager.swift
//
//
//  Created by Noah Little on 14/12/2022.
//

import Foundation
import SwiftUI
import Comet

final class PreferenceManager {
    static let shared = PreferenceManager()
    
    var settings: Settings {
        underlyingSettings
    }
    
    private var underlyingSettings: Settings!
    let defaults = UserDefaults.standard
    
    func loadSettings(withDictionary dict: [String: Any]) {
        self.underlyingSettings = .init(withDictionary: dict)
    }
}

struct Settings {
    let isEnabled: Bool
    let statusBar: StatusBar
    let lockScreen: LockScreen
    let clocks: [ClockInfo]
    let isEnabled24HourMode: Bool
    
    init(withDictionary dict: [String: Any]) {
        isEnabled = dict["isEnabled"] as? Bool ?? true
        isEnabled24HourMode = dict["isEnabled24HourMode"] as? Bool ?? false

        // Status bar
        statusBar = .init(
            isEnabled: dict["isEnabledSB"] as? Bool ?? false,
            isEnabledAMPM: dict["isEnabledAMPM"] as? Bool ?? false
        )
        
        // Lock screen
        let timeTemplate: DateTemplate = {
            switch dict["timeTemplate"] as? Int ?? 0 {
            case 0:
                return .time
            case 1:
                return .timeWithSeconds
            case 2:
                return .timeCustom(dict["timeTemplateCustomFormat"] as? String ?? "h:mm")
            default:
                return .time
            }
        }()
        
        let dateTemplate: DateTemplate = {
            switch dict["dateTemplate"] as? Int ?? 0 {
            case 0:
                return .date
            case 1:
                return .dateCustom(dict["dateTemplateCustomFormat"] as? String ?? "EEEE, MMMM d")
            default:
                return .date
            }
        }()
        
        lockScreen = .init(
            isEnabled: dict["isEnabledLS"] as? Bool ?? true,
            colorMode: ColorMode(rawValue: dict["colorMode"] as? Int ?? 0)!,
            primaryClockAppearance: .init(
                nameColor: .init(hex: dict["primaryNameColor"] as? String ?? "FFFFFF"),
                timeColor: .init(hex: dict["primaryTimeColor"] as? String ?? "FFFFFF"),
                dateColor: .init(hex: dict["primaryDateColor"] as? String ?? "FFFFFF")
            ),
            secondaryClockAppearance: .init(
                nameColor: .init(hex: dict["secondaryNameColor"] as? String ?? "FFFFFF"),
                timeColor: .init(hex: dict["secondaryTimeColor"] as? String ?? "FFFFFF"),
                dateColor: .init(hex: dict["secondaryDateColor"] as? String ?? "FFFFFF")
            ),
            timeTemplate: timeTemplate,
            dateTemplate: dateTemplate,
            showSeconds: dict["showSeconds"] as? Bool ?? false,
            selectedFont: FontType(rawValue: dict["selectedFont"] as? Int ?? 2)!,
            secondsColor: UIColor(hex: dict["secondsColor"] as? String ?? "FFFFFF"),
            verticalOffset: dict["verticalOffset"] as? Double ?? 0.0
        )
        
        // Primary clock
        let primaryTimeZoneID = dict["primaryTimeZoneID"] as? String ?? TimeZone.autoupdatingCurrent.identifier
        let isEnabledCustomTimeZonePrimary = dict["isEnabledCustomTimeZonePrimary"] as? Bool ?? false
        
        let primaryTimeZone: TimeZone = {
            guard isEnabledCustomTimeZonePrimary,
                  let timeZone = TimeZone(identifier: primaryTimeZoneID)
            else {  return .autoupdatingCurrent }
            return timeZone
        }()
        
        let primaryLocale: Locale = {
            guard let identifier = dict["primaryLocaleID"] as? String else {
                return Locale.current
            }
            return Locale(identifier: identifier)
        }()
        
        let primaryClock = ClockInfo(
            isPrimary: true,
            timeZone: primaryTimeZone,
            locale: primaryLocale,
            name: (dict["primaryName"] as? String)?.nilIfEmpty
        )
        
        // Secondary clock
        let secondaryTimeZoneID = dict["secondaryTimeZoneID"] as? String ?? TimeZone.autoupdatingCurrent.identifier
        let isEnabledCustomTimeZoneSecondary = dict["isEnabledCustomTimeZoneSecondary"] as? Bool ?? false
        
        let secondaryTimeZone: TimeZone = {
            guard isEnabledCustomTimeZoneSecondary,
                  let timeZone = TimeZone(identifier: secondaryTimeZoneID)
            else { return .autoupdatingCurrent }
            return timeZone
        }()
        
        let secondaryLocale: Locale = {
            guard let identifier = dict["secondaryLocaleID"] as? String else {
                return Locale.current
            }
            return Locale(identifier: identifier)
        }()
        
        let secondaryClock = ClockInfo(
            isPrimary: false,
            timeZone: secondaryTimeZone,
            locale: secondaryLocale,
            name: (dict["secondaryName"] as? String)?.nilIfEmpty
        )
        
        clocks = [
            primaryClock,
            secondaryClock
        ]
    }
}
