//
//  FontSettings.swift
//  freedom_rosary
//
//  Created by Charles Michael on 12/24/25.
//

import Foundation

import SwiftUI

enum AppStorageKeys {
    static let fontSize = "fontSize"
}

struct FontSettings {
    static func font(from raw: String) -> FontSize {
        FontSize(rawValue: raw) ?? .small
    }
}
