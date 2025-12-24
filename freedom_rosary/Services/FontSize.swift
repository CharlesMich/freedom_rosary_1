//
//  FontSize.swift
//  freedom_rosary
//
//  Created by Charles Michael on 12/24/25.
//

import Foundation
import SwiftUI

enum FontSize: String, CaseIterable {
    case small, medium, large
    
    var font: Font {
        switch self {
        case .small: return .body
        case .medium: return .title3
        case .large: return .title2
        }
    }
    
    var scale: CGFloat {
        switch self {
        case .small: return 1.0
        case .medium: return 1.2
        case .large: return 1.4
        }
    }
}
