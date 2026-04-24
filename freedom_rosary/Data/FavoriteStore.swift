//
//  FavoriteStore.swift
//  freedom_rosary
//
//  Created by Charles Michael on 12/31/25.
//

import SwiftUI

final class FavoritesStore: ObservableObject {

    @AppStorage("favoriteTopics")
    private var storedFavorites: String = ""

    @Published private(set) var favorites: Set<String> = []

    init() {
        favorites = Set(storedFavorites.split(separator: "|").map(String.init))
    }

    // MARK: - Public API

    func isFavorite(_ topic: Topic) -> Bool {
        favorites.contains(topic.name)
    }

    func toggleFavorite(_ topic: Topic) {
        if favorites.contains(topic.name) {
            favorites.remove(topic.name)
        } else {
            favorites.insert(topic.name)
        }
        persist()
    }

    // MARK: - Persistence

    private func persist() {
        storedFavorites = favorites.joined(separator: "|")
    }
}


