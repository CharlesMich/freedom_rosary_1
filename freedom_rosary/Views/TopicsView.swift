//
//  TopicsView.swift
//  freedom_rosary
//
//  Created by Charles Michael on 12/23/25.
//

//
//  TopicsView.swift
//  freedom_rosary
//

import SwiftUI

// MARK: - Row
import SwiftUI

struct TopicRow: View {
    let topic: Topic
    let font: Font
    let color: Color
    let isFavorite: Bool

    var body: some View {
        VStack(spacing: 0) {
            NavigationLink {
                RosaryDetailView(topic: topic)
            } label: {
                HStack {
                    Text(topic.name)
                        .font(font)
                        .fontWeight(.regular)
                        .foregroundColor(color)

                    Spacer()

                    // ❤️ Subtle favorite indicator
                    if isFavorite {
                        Image(systemName: "heart.fill")
                            .font(.caption)
                            .foregroundColor(.red.opacity(0.7))
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }

            Divider()
                .background(color)
        }
    }
}


// MARK: - Topics View
struct TopicsView: View {

    private let topics: [Topic]

    init(topics: [Topic] = TopicLoader.load()) {
        self.topics = topics
    }
    
    @EnvironmentObject private var favoritesStore: FavoritesStore
    @Environment(\.colorScheme) private var colorScheme
    @State private var searchText: String = ""

    // Font size
    @AppStorage(AppStorageKeys.fontSize)
    private var fontSizeRaw: String = FontSize.small.rawValue

    private var fontSize: FontSize {
        FontSettings.font(from: fontSizeRaw)
    }

    // MARK: - Filtered Topics
    private var filteredTopics: [Topic] {
        guard !searchText.isEmpty else { return topics }

        let query = searchText.lowercased()

        return topics.filter { topic in
            topic.name.lowercased().contains(query) ||
            topic.keywords.contains { $0.lowercased().contains(query) }
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(filteredTopics) { topic in
                        TopicRow(
                            topic: topic,
                            font: fontSize.font,
                            color: colorScheme == .dark ? .white : .black,
                            isFavorite: favoritesStore.isFavorite(topic)
                        )
                    }
                }
                .background(colorScheme == .dark ? Color.black : Color.white)
            }
            .navigationTitle("Topics")
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search topics or keywords"
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        switch fontSizeRaw {
                        case FontSize.small.rawValue:
                            fontSizeRaw = FontSize.medium.rawValue
                        case FontSize.medium.rawValue:
                            fontSizeRaw = FontSize.large.rawValue
                        default:
                            fontSizeRaw = FontSize.small.rawValue
                        }
                    } label: {
                        Image(systemName: "textformat")
                            .imageScale(.large)
                            .scaleEffect(FontSize(rawValue: fontSizeRaw)?.scale ?? 1.0)
                    }
                }
            }
        }
    }
}

#Preview {
    let mockTopics: [Topic] = [
        Topic(
            name: "Joyful Mysteries",
            jsonFileName: "joyful",
            whoShouldMeditate: "",
            keywords: ["joy", "incarnation", "mary"]
        ),
        Topic(
            name: "Anger",
            jsonFileName: "anger",
            whoShouldMeditate: "Those who struggle with anger.",
            keywords: ["anger", "rage", "temper"]
        ),
        Topic(
            name: "Patience",
            jsonFileName: "patience",
            whoShouldMeditate: "Those seeking perseverance.",
            keywords: ["patience", "endurance"]
        )
    ]

    let favoritesStore = FavoritesStore()

    return Group {
        NavigationStack {
            TopicsView(topics: mockTopics)
        }
        .environmentObject(favoritesStore)
        .preferredColorScheme(.light)

        NavigationStack {
            TopicsView(topics: mockTopics)
        }
        .environmentObject(favoritesStore)
        .preferredColorScheme(.dark)
    }
}

