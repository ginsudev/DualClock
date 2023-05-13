//
//  ClocksView.swift
//  
//
//  Created by Noah Little on 7/5/2023.
//

import SwiftUI
import GSCore

struct ClocksView: View {
    @EnvironmentObject var preferenceStorage: PreferenceStorage
    var body: some View {
        Form {
            clockSection(isPrimary: true)
            clockSection(isPrimary: false)
            
            Section {
                Toggle(Copy.twentyFourHourMode, isOn: $preferenceStorage.isEnabled24HourMode)
            }
        }
        .navigationTitle(Copy.clocks)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                AlertRespringButton()
            }
        }
    }
    
    @ViewBuilder
    private func clockSection(isPrimary: Bool) -> some View {
        let selectedTimezone = isPrimary
        ? $preferenceStorage.primaryTimeZoneID
        : $preferenceStorage.secondaryTimeZoneID
        
        let selectedLocale = isPrimary
        ? $preferenceStorage.primaryLocaleID
        : $preferenceStorage.secondaryLocaleID
        
        let isEnabledCustomTimeZone = isPrimary
        ? $preferenceStorage.isEnabledCustomTimeZonePrimary
        : $preferenceStorage.isEnabledCustomTimeZoneSecondary
        
        let name = isPrimary
        ? $preferenceStorage.primaryName
        : $preferenceStorage.secondaryName
        
        Section {
            Toggle(Copy.customTimeZone, isOn: isEnabledCustomTimeZone.animation())
            if isEnabledCustomTimeZone.wrappedValue {
                NavigationLink {
                    SearchableListView(selected: selectedTimezone, strings: TimeZone.knownTimeZoneIdentifiers)
                        .navigationTitle(Copy.timeZone)
                } label: {
                    HStack {
                        Text(Copy.timeZone)
                        Spacer()
                        Text(selectedTimezone.wrappedValue)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            NavigationLink {
                SearchableListView(selected: selectedLocale, strings: Locale.availableIdentifiers)
                    .navigationTitle(Copy.locale)
            } label: {
                HStack {
                    Text(Copy.locale)
                    Spacer()
                    Text(selectedLocale.wrappedValue)
                        .foregroundColor(.secondary)
                }
            }
            
            HStack {
                Text(Copy.nameColon)
                TextField(
                    selectedTimezone.wrappedValue.components(separatedBy: "/")[1],
                    text: name
                )
            }
        } header: {
            Text(isPrimary ? Copy.primary : Copy.secondary)
        }
    }
}

struct ClocksView_Previews: PreviewProvider {
    static var previews: some View {
        ClocksView()
    }
}
