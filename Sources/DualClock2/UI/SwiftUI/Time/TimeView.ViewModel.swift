//
//  TimeView.ViewModel.swift
//  
//
//  Created by Noah Little on 14/5/2023.
//

import Foundation

extension TimeView {
    final class ViewModel: ObservableObject {
        @Published private(set) var timeString = "--:--"
        @Published private(set) var dateString = "--/--/--"
        @Published private(set) var iconName = ""
        @Published private(set) var nameString: String
        
        let settings = PreferenceManager.shared.settings.lockScreen
        let appearance: Settings.ClockAppearance
        private let name: String?
        
        init(
            name: String?,
            appearance: Settings.ClockAppearance
        ) {
            self.name = name
            self.nameString = name ?? "--"
            self.appearance = appearance
        }
        
        func refresh(withTimeZone timeZone: TimeZone) {
            iconName = timeZone.icon
            nameString = name ?? timeZone.placeName
        }
        
        func updateStrings(
            withTimeZone timeZone: TimeZone,
            locale: Locale
        ) {
            if let timeString = settings.timeTemplate.dateString(timeZone: timeZone, locale: locale),
               let dateString = settings.dateTemplate.dateString(timeZone: timeZone, locale: locale) {
                self.timeString = timeString
                self.dateString = dateString
            }
        }
    }
}
