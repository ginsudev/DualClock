//
//  LockScreenView.swift
//  
//
//  Created by Noah Little on 7/5/2023.
//

import SwiftUI
import Comet
import GSCore

// MARK: - Internal

struct LockScreenView: View {
    @EnvironmentObject var preferenceStorage: PreferenceStorage
    private let viewModel = ViewModel()
    
    var body: some View {
        Form {
            Toggle(Copy.enabled, isOn: $preferenceStorage.isEnabledLS.animation())
            options
                .disabled(!preferenceStorage.isEnabledLS)
        }
        .navigationTitle(Copy.lockScreen)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                AlertRespringButton()
            }
        }
    }
}

// MARK: - Private

private extension LockScreenView {
    @ViewBuilder
    var options: some View {
        Section {
            Toggle(Copy.singleDate, isOn: $preferenceStorage.isSingleDate)
        } footer: {
            Text(Copy.singleDateDesc)
        }
        
        timeFormattingSection
        
        if !preferenceStorage.isSingleDate {
            dateFormattingSection
        }
        
        Section {
            Toggle(Copy.showSeconds, isOn: $preferenceStorage.showSeconds.animation())
        }
        
        Section {
            DetailedSlider(
                value: $preferenceStorage.verticalOffset,
                range: -500.0...1000.0,
                title: Copy.verticalOffset
            )
        } header: {
            Text(Copy.verticalOffset)
        } footer: {
            Text(Copy.moveDualClockUpDown)
        }
        
        Section {
            Picker(Copy.colorMode, selection: $preferenceStorage.colorMode.animation()) {
                ForEach(ColorMode.allCases) { mode in
                    Text(mode.title)
                        .tag(mode.rawValue)
                }
            }
            .pickerStyle(.segmented)
        } header: {
            Text(Copy.colors)
        } footer: {
            Text(Copy.adaptiveColorDesc)
        }
        
        if ColorMode(rawValue: preferenceStorage.colorMode) == .custom {
            colorSection(isPrimary: true)
            colorSection(isPrimary: false)
            if preferenceStorage.showSeconds {
                Section {
                    HexColorPicker(
                        selectedColorHex: $preferenceStorage.secondsColor,
                        title: Copy.color(Copy.seconds)
                    )
                }
            }
        }
        
        fontSection
    }
    
    var timeFormattingSection: some View {
        Section {
            Text(formattedTimeString)
                .foregroundColor(.secondary)
            Picker(
                Copy.timeFormat,
                selection: $preferenceStorage.selectedTimeTemplate.animation()) {
                    ForEach(TimeTemplate.allCases, id: \.rawValue) {
                        Text($0.title)
                            .tag($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
            if TimeTemplate(rawValue: preferenceStorage.selectedTimeTemplate) == .custom {
                TextField("h:mm", text: $preferenceStorage.timeTemplateCustomFormat)
            }
        } header: {
            Text(Copy.timeFormatting)
        }
    }
    
    var dateFormattingSection: some View {
        Section {
            Text(formattedDateString)
                .foregroundColor(.secondary)
            Picker(
                Copy.dateFormat,
                selection: $preferenceStorage.selectedDateTemplate.animation()) {
                    ForEach(DateTemplate.allCases, id: \.rawValue) {
                        Text($0.title)
                            .tag($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
            if DateTemplate(rawValue: preferenceStorage.selectedDateTemplate) == .custom {
                TextField("EEEE, MMMM d", text: $preferenceStorage.dateTemplateCustomFormat)
            }
        } header: {
            Text(Copy.dateFormatting)
        }
    }
    
    var formattedDateString: String {
        let format = DateTemplate(rawValue: preferenceStorage.selectedDateTemplate)?.format ?? preferenceStorage.dateTemplateCustomFormat
        return format.isEmpty ? Copy.preview :  viewModel.formattedDate(format: format)
    }
    
    var formattedTimeString: String {
        let format = TimeTemplate(rawValue: preferenceStorage.selectedTimeTemplate)?.format ?? preferenceStorage.timeTemplateCustomFormat
        return format.isEmpty ? Copy.preview : viewModel.formattedDate(format: format)
    }
    
    var fontSection: some View {
        Section {
            Picker(Copy.font, selection: $preferenceStorage.selectedFont) {
                ForEach(FontType.allCases, id: \.rawValue) {
                    Text($0.title)
                        .tag($0.rawValue)
                }
            }
            .pickerStyle(.wheel)
        } header: {
            Text(Copy.fonts)
        }
    }
    
    @ViewBuilder
    func colorSection(isPrimary: Bool) -> some View {
        let nameColor = isPrimary
        ? $preferenceStorage.primaryNameColor
        : $preferenceStorage.secondaryNameColor
        
        let timeColor = isPrimary
        ? $preferenceStorage.primaryTimeColor
        : $preferenceStorage.secondaryTimeColor

        let dateColor = isPrimary
        ? $preferenceStorage.primaryDateColor
        : $preferenceStorage.secondaryDateColor
        
        Section {
            HexColorPicker(selectedColorHex: nameColor, title: Copy.color(Copy.name))
            HexColorPicker(selectedColorHex: timeColor, title: Copy.color(Copy.time))
            HexColorPicker(selectedColorHex: dateColor, title: Copy.color(Copy.date))
        } header: {
            Text(isPrimary ? Copy.primary : Copy.secondary)
        }
    }
}

// MARK: - Previews

struct LockScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LockScreenView()
    }
}
