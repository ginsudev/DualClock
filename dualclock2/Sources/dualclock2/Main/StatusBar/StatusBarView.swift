//
//  StatusBarView.swift
//  
//
//  Created by Noah Little on 7/5/2023.
//

import SwiftUI
import GSCore

struct StatusBarView: View {
    @EnvironmentObject var preferenceStorage: PreferenceStorage
    var body: some View {
        Form {
            Toggle(Copy.enabled, isOn: $preferenceStorage.isEnabledSB)
            Toggle(Copy.showAMPM, isOn: $preferenceStorage.isEnabledAMPM)
        }
        .navigationTitle(Copy.statusBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                AlertRespringButton()
            }
        }
    }
}

struct StatusBarView_Previews: PreviewProvider {
    static var previews: some View {
        StatusBarView()
    }
}
