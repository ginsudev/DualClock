//
//  Formatters.swift
//  
//
//  Created by Noah Little on 7/5/2023.
//

import Foundation

enum DateTemplate: Equatable {
    case timeWithSeconds
    case time
    case timeAMPM
    case timeCustom(String)
    case date
    case dateCustom(String)
    case seconds
    
    var id: Self { self }
    
    func dateString(
        date: Date? = nil,
        timeZone: TimeZone = .current,
        locale: Locale = .current
    ) -> String? {
        guard let formatter = Formatters.formatter(template: self) else { return nil }
        formatter.locale = locale
        formatter.timeZone = timeZone
        return formatter.string(from: date ?? Date())
    }
}

struct Formatters {
    static let time = createFormatter(format: "h:mm".twentyFourHourized)
    
    static let timeAMPM = createFormatter(format: "h:mm a")

    static let timeWithSeconds = createFormatter(format: "h:mm:ss".twentyFourHourized)
    
    static let seconds = createFormatter(format: "ss")
    
    static let date = createFormatter(format: "EEEE, MMMM d")
    
    static let customTimeFormatter: DateFormatter? = {
        if case let .timeCustom(format) = PreferenceManager.shared.settings.lockScreen.timeTemplate {
            return createFormatter(format: format)
        } else {
            return nil
        }
    }()
    
    static let customDateFormatter: DateFormatter? = {
        if case let .dateCustom(format) = PreferenceManager.shared.settings.lockScreen.dateTemplate {
            return createFormatter(format: format)
        } else {
            return nil
        }
    }()
    
    static func formatter(template: DateTemplate) -> DateFormatter? {
        switch template {
        case .timeWithSeconds: return timeWithSeconds
        case .time: return time
        case .timeCustom: return customTimeFormatter
        case .date: return date
        case .dateCustom: return customDateFormatter
        case .seconds: return seconds
        case .timeAMPM: return timeAMPM
        }
    }
    
    private static func createFormatter(format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter
    }
}

fileprivate extension String {
    var twentyFourHourized: Self {
        if PreferenceManager.shared.settings.isEnabled24HourMode {
            return replacingOccurrences(of: "h:", with: "HH:")
        } else { return self }
    }
}
