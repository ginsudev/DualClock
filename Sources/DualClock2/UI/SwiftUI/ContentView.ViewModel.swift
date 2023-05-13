//
//  ContentView.ViewModel.swift
//  
//
//  Created by Noah Little on 7/5/2023.
//

import Foundation

extension ContentView {
    struct ViewModel {
        let settings = PreferenceManager.shared.settings
        
        func appearance(clockInfo: Settings.ClockInfo) -> Settings.ClockAppearance {
            if clockInfo.isPrimary {
                return settings.lockScreen.primaryClockAppearance
            } else {
                return settings.lockScreen.secondaryClockAppearance
            }
        }
    }
}
