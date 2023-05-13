//
//  TimeView.swift
//  
//
//  Created by Noah Little on 7/5/2023.
//

import SwiftUI

// MARK: - Internal

struct TimeView: View {
    @Environment(\.fontDesign) var fontDesign
    @Environment(\.timeZone) var timeZone
    @Environment(\.locale) var locale
    @Environment(\.isLandscape) var isLandscape
    @EnvironmentObject var localState: LocalState
    
    @State private var timeString = "--:--"
    @State private var dateString = "--/--/--"
        
    let name: String?
    let appearance: Settings.ClockAppearance
    
    private let settings = PreferenceManager.shared.settings.lockScreen

    var body: some View {
        Group {
            if isLandscape {
                landscapeView
            } else {
                portraitView
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .refreshContent)) { _ in
            updateStrings()
        }
    }
}

// MARK: - Private

private extension TimeView {
    var portraitView: some View {
        VStack {
            titleView(isVisibleName: true)
            timeView
            dateView
        }
    }
    
    var landscapeView: some View {
        HStack {
            titleView(isVisibleName: false)
            timeView
        }
    }
    
    var timeView: some View {
        Text(timeString)
            .font(.system(size: 50.0, design: fontDesign))
            .foregroundColor(Color(timeColor))
    }
    
    var dateView: some View {
        Text(dateString)
            .font(.system(.body, design: fontDesign))
            .foregroundColor(Color(dateColor))
    }
    
    func titleView(isVisibleName: Bool) -> some View {
        HStack {
            Image(systemName: appearance.iconName)
                .opacity(0.5)
            if isVisibleName {
                Text(nameString)
            }
        }
        .foregroundColor(Color(nameColor))
        .font(.system(.body, design: fontDesign))
    }
    
    var nameString: String {
        name ?? timeZone.placeName
    }
    
    var nameColor: UIColor {
        localState.wallpaperSuitableForegroundColor ?? appearance.nameColor
    }
    
    var timeColor: UIColor {
        localState.wallpaperSuitableForegroundColor ?? appearance.timeColor
    }
    
    var dateColor: UIColor {
        localState.wallpaperSuitableForegroundColor ?? appearance.dateColor
    }
    
    func updateStrings() {
        if let timeString = settings.timeTemplate.dateString(timeZone: timeZone, locale: locale),
           let dateString = settings.dateTemplate.dateString(timeZone: timeZone, locale: locale) {
            self.timeString = timeString
            self.dateString = dateString
        }
    }
}
