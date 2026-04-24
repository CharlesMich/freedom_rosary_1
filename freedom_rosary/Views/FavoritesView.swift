//
//  FavoritesView.swift
//  freedom_rosary
//
//  Created by Charles Michael on 12/23/25.
//

import SwiftUI

struct FavoritesView: View {

    @EnvironmentObject private var favoritesStore: FavoritesStore
    @Environment(\.colorScheme) var colorScheme

    @AppStorage(AppStorageKeys.fontSize)
    private var fontSizeRaw: String = FontSize.small.rawValue

    private var fontSize: FontSize {
        FontSettings.font(from: fontSizeRaw)
    }

    private let allTopics = TopicLoader.load()

    private var favoriteTopics: [Topic] {
        allTopics.filter { favoritesStore.isFavorite($0) }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                if favoriteTopics.isEmpty {

                    // MARK: Empty State
                    VStack(spacing: 16) {
                        Image(systemName: "heart")
                            .font(.largeTitle)
                            .foregroundColor(.secondary)

                        Text("No favorites yet")
                            .font(.headline)

                        Text("Tap the heart icon on a topic to add it here.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity, minHeight: 300)
                    .padding(.top, 80)

                } else {

                    // MARK: Favorites List (same as TopicsView)
                    VStack(spacing: 0) {
                        ForEach(favoriteTopics) { topic in
                            TopicRow(
                                topic: topic,
                                font: fontSize.font,
                                color: colorScheme == .dark ? .white : .black,
                                isFavorite: true   // ✅ FIX
                               
                            )
                        }
                    }
                }
            }
            .background(colorScheme == .dark ? Color.black : Color.white)
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesView()
        .environmentObject(FavoritesStore())
}

