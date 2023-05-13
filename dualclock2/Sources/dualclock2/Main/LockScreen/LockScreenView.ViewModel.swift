//
//  LockScreenView.ViewModel.swift
//  
//
//  Created by Noah Little on 7/5/2023.
//

import Foundation

extension LockScreenView {
    enum ColorMode: Int, Identifiable, CaseIterable {
        case adaptive
        case custom
        
        var title: String {
            switch self {
            case .adaptive: return Copy.adaptive
            case .custom: return Copy.custom
            }
        }
        
        var id: Self { self }
    }
    
    enum TimeTemplate: Int, CaseIterable {
        case `default`
        case custom
        
        var title: String {
            switch self {
            case .default: return Copy.default
            case .custom: return Copy.custom
            }
        }
        
        var format: String? {
            switch self {
            case .default: return "h:mm"
            case .custom: return nil
            }
        }
    }
    
    enum DateTemplate: Int, CaseIterable {
        case `default`
        case custom
        
        var title: String {
            switch self {
            case .default: return Copy.default
            case .custom: return Copy.custom
            }
        }
        
        var format: String? {
            switch self {
            case .default: return "EEEE, MMMM d"
            case .custom: return nil
            }
        }
    }
    
    enum FontType: Int, CaseIterable {
        case `default`
        case monospaced
        case rounded
        case serif
        
        var title: String {
            switch self {
            case .default: return Copy.default
            case .monospaced: return Copy.monospaced
            case .rounded: return Copy.rounded
            case .serif: return Copy.serif
            }
        }
    }
    
    struct ViewModel {
        func formattedDate(format: String) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            return formatter.string(from: Date())
        }
    }
}
