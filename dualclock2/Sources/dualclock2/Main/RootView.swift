import SwiftUI
import GSCore
import Comet

struct RootView: View {
    @StateObject private var preferenceStorage = PreferenceStorage()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Colors.formBackground
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 25) {
                    headerView
                    enableButton
                    sections
                    respringButton
                    Spacer()
                    CopywriteView()
                }
                .padding()
            }
        }
    }
}

private extension RootView {
    var headerView: some View {
        HeaderView(
            viewModel: .init(
                title: "DualClock 2",
                version: "2.0.1",
                author: .ginsu
            )
        )
    }
    
    var enableButton: some View {
        PreferenceCell(cell: .enabled(isEnabled: $preferenceStorage.isEnabled))
    }
    
    var sections: some View {
        DetailedNavigationLinkGroupView(links: [
            DetailedNavigationLink(
                cell: .custom(
                    title: Copy.clocks,
                    subtitle: Copy.setupClocks,
                    imageName: "clock",
                    accessibility: .chevron,
                    isAnimated: false
                )
            ) {
                AnyView(
                    ClocksView()
                        .environmentObject(preferenceStorage)
                )
            },
            DetailedNavigationLink(
                cell: .custom(
                    title: Copy.lockScreen,
                    subtitle: Copy.configureLS,
                    imageName: "lock.square",
                    accessibility: .chevron,
                    isAnimated: false
                )
            ) {
                AnyView(
                    LockScreenView()
                        .environmentObject(preferenceStorage)
                )
            },
            DetailedNavigationLink(
                cell: .custom(
                    title: Copy.statusBar,
                    subtitle: Copy.configureSB,
                    imageName: "apps.iphone",
                    accessibility: .chevron,
                    isAnimated: false
                )
            ) {
                AnyView(
                    StatusBarView()
                        .environmentObject(preferenceStorage)
                )
            }
        ])
    }
    
    var respringButton: some View {
        Button {
            DeviceService().respring()
        } label: {
            PreferenceCell(cell: .respring)
        }
    }
}
