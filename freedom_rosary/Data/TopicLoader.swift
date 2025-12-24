//
//  TopicLoader.swift
//  freedom_rosary
//
//  Created by Charles Michael on 12/24/25.
//

import Foundation

final class TopicLoader {
    static func load() -> [Topic] {
        guard let url = Bundle.main.url(forResource: "topics", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let topics = try? JSONDecoder().decode([Topic].self, from: data) else {
            return []
        }
        return topics
    }
}
