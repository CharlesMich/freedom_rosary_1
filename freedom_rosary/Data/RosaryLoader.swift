//
//  RosaryLoader.swift
//  freedom_rosary
//
//  Created by Charles Michael on 12/24/25.
//

import Foundation

final class RosaryLoader {

    static func load(fileName: String) -> [RosaryVerse] {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("❌ \(fileName).json not found in bundle")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([RosaryVerse].self, from: data)
            print("✅ Loaded \(decoded.count) verses from \(fileName).json")
            return decoded
        } catch {
            print("❌ Failed to decode \(fileName).json: \(error)")
            return []
        }
    }
}
