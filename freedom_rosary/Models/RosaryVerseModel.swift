//
//  RosaryVerseModel.swift
//  freedom_rosary
//
//  Created by Charles Michael on 12/24/25.
//

import Foundation

struct RosaryVerse: Codable, Identifiable {
    var id = UUID()
    let verse: String
    let decade: Int

    // Exclude `id` from Codable
    enum CodingKeys: String, CodingKey {
        case verse, decade
    }
}

