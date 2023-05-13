//
//  ContentView.swift
//  
//
//  Created by Noah Little on 7/5/2023.
//

import SwiftUI
import GSCore

struct ContentView: View {
    @StateObject private var localState = LocalState.shared
    @StateObject private var globalState = GlobalState.shared
    @State private var landscapeWidth: CGFloat = .zero
    private let viewModel = ViewModel()
    
    var body: some View {
        Group{
            if globalState.isLandscapeExcludingiPad {
                landscapeView
            } else {
                portraitView
            }
        }
        .frame(maxWidth: .greatestFiniteMagnitude)
        .environment(\.fontDesign, viewModel.settings.lockScreen.selectedFont.representedFont)
        .environment(\.isLandscape, globalState.isLandscapeExcludingiPad)
        .environmentObject(localState)
    }
    
    private func clockView(clock: Settings.ClockInfo) -> some View {
        TimeView(
            name: clock.name,
            appearance: viewModel.appearance(clockInfo: clock)
        )
        .environment(\.timeZone, clock.timeZone)
        .environment(\.locale, clock.locale)
        .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .infinity)
        .fixedSize(horizontal: globalState.isLandscapeExcludingiPad, vertical: false)
    }
}

private extension ContentView {
    var portraitView: some View {
        HStack {
            clockView(clock: viewModel.settings.clocks[0])
            secondsView()
            clockView(clock: viewModel.settings.clocks[1])
        }
    }
    
    var landscapeView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0.0) {
                VStack(alignment: .leading) {
                    clockView(clock: viewModel.settings.clocks[0])
                    clockView(clock: viewModel.settings.clocks[1])
                }
                .background(GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            landscapeWidth = proxy.size.width
                        }
                })
                secondsView(width: landscapeWidth)
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    func secondsView(width: CGFloat = .zero) -> some View {
        if viewModel.settings.lockScreen.showSeconds {
            SecondsView(width: width)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
