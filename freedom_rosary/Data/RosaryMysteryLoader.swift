//
//  RosaryMysteryLoader.swift
//  freedom_rosary
//
//  Created by Charles Michael on 12/24/25.
//

import Foundation

enum RosaryMysteryLoader {

    static func load() -> [RosaryMystery] {
        guard
            let url = Bundle.main.url(forResource: "mysteries", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let decoded = try? JSONDecoder().decode([RosaryMystery].self, from: data)
        else {
            return []
        }
        return decoded
    }
}
