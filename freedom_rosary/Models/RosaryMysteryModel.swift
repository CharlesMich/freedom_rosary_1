//
//  RosaryMysteryModel.swift
//  freedom_rosary
//
//  Created by Charles Michael on 12/24/25.
//

import Foundation

struct RosaryMystery: Identifiable, Decodable {
    let topic: String
    let decade: Int
    let mystery: String

    // Computed ID (not decoded)
    var id: String {
        "\(topic)-\(decade)"
    }
}

