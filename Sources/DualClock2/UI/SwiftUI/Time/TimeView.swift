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
    @StateObject private var viewModel: ViewModel

    init(
        name: String? = nil,
        appearance: Settings.ClockAppearance
    ) {
        _viewModel = .init(
            wrappedValue: .init(
                name: name,
                appearance: appearance
            )
        )
    }

    var body: some View {
        Group {
            if isLandscape {
                landscapeView
            } else {
                portraitView
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .NSSystemTimeZoneDidChange).prepend(.init(name: .prepended))) { _ in
            viewModel.refresh(withTimeZone: timeZone)
        }
        .onReceive(NotificationCenter.default.publisher(for: .refreshContent)) { _ in
            viewModel.updateStrings(withTimeZone: timeZone, locale: locale)
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
        Text(viewModel.timeString)
            .font(.system(size: 50.0, design: fontDesign))
            .foregroundColor(Color(timeColor))
    }
    
    @ViewBuilder
    var dateView: some View {
        if !viewModel.settings.isSingleDate {
            Text(viewModel.dateString)
                .font(.system(.body, design: fontDesign))
                .foregroundColor(Color(dateColor))
        }
    }
    
    func titleView(isVisibleName: Bool) -> some View {
        HStack {
            Image(systemName: viewModel.iconName)
                .opacity(0.5)
            if isVisibleName {
                Text(viewModel.nameString)
            }
        }
        .foregroundColor(Color(nameColor))
        .font(.system(.body, design: fontDesign))
    }
    
    var nameColor: UIColor {
        localState.wallpaperSuitableForegroundColor ?? viewModel.appearance.nameColor
    }
    
    var timeColor: UIColor {
        localState.wallpaperSuitableForegroundColor ?? viewModel.appearance.timeColor
    }
    
    var dateColor: UIColor {
        localState.wallpaperSuitableForegroundColor ?? viewModel.appearance.dateColor
    }
}
