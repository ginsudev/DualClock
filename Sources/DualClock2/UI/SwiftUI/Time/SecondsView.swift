//
//  SecondsView.swift
//  
//
//  Created by Noah Little on 7/5/2023.
//

import SwiftUI

// MARK: - Internal

struct SecondsView: View {
    @Environment(\.isLandscape) var isLandscape
    @Environment(\.fontDesign) var fontDesign
    @EnvironmentObject var localState: LocalState
    @State private var currentSecond = 0
    
    private let settings = PreferenceManager.shared.settings.lockScreen
    private let width: CGFloat
    
    init(width: CGFloat = .zero) {
        self.width = width
    }
    
    var body: some View {
        Group {
            if isLandscape {
                landscapeView
            } else {
                portraitView
            }
        }
        .foregroundColor(Color(foregroundColor))
        .onReceive(NotificationCenter.default.publisher(for: .refreshContent)) { _ in
            withAnimation(.easeIn(duration: 1.0)) {
                currentSecond = Calendar.current.component(.second, from: Date())
            }
        }
    }
}

// MARK: - Private

private extension SecondsView {
    var portraitView: some View {
        ZStack {
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 3.5))
                .opacity(0.3)
            Circle()
                .trim(from: 0.0, to: fill)
                .stroke(style: .init(lineWidth: 3.5, lineCap: .round, lineJoin: .round))
                .rotationEffect(.degrees(-90))
            textView
        }
        .frame(width: 35, height: 35)
    }
    
    var landscapeView: some View {
        HStack {
            textView
                .fixedSize()
            ZStack(alignment: .leading) {
                Capsule()
                    .frame(width: width, height: 5.0)
                    .opacity(0.3)
                Capsule()
                    .frame(width: width * fill, height: 5.0)
            }
        }
    }
    
    var textView: some View {
        Text("\(currentSecond)")
            .font(.system(.caption, design: fontDesign))
    }
    
    var fill: Double {
        Double(currentSecond) / 60.0
    }
    
    var foregroundColor: UIColor {
        guard let averageColor = localState.wallpaperSuitableForegroundColor else {
            return settings.secondsColor
        }
        return averageColor
    }
}

// MARK: - Previews

struct SecondsView_Previews: PreviewProvider {
    static var previews: some View {
        SecondsView()
    }
}
