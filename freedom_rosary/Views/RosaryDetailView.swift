//
//  RosaryDetailView.swift
//  freedom_rosary
//

import SwiftUI

struct RosaryDetailView: View {

    let topic: Topic
    var loadedVerses: [RosaryVerse]? = nil
    var loadedMysteries: [RosaryMystery]? = nil

    @State private var currentDecade: Int = 1
    private let maxDecades = 5
    
    private let scrollTopID = "SCROLL_TOP"

    // Font size
    @AppStorage(AppStorageKeys.fontSize) private var fontSizeRaw: String = FontSize.small.rawValue
    private var font: Font {
        FontSize(rawValue: fontSizeRaw)?.font ?? .body
    }

    // Navigation to Closing Prayers
    @State private var navigateToClosingPrayers = false

    // MARK: - Verses for current decade
    private var verses: [RosaryVerse] {
        let all = loadedVerses ?? RosaryLoader.load(fileName: topic.jsonFileName)
        return all.filter { $0.decade == currentDecade }
    }

    // MARK: - Mystery subtitle
    private var mysterySubtitle: String? {
        let mysteries = loadedMysteries ?? RosaryMysteryLoader.load()
        return mysteries.first {
            $0.topic == topic.name && $0.decade == currentDecade
        }?.mystery
    }

    // MARK: - Show WhoShouldMeditate button
    private var shouldShowDescriptionButton: Bool {
        let excludedTopics = [
            "Joyful Mysteries",
            "Sorrowful Mysteries",
            "Luminous Mysteries",
            "Glorious Mysteries"
        ]
        return !excludedTopics.contains(topic.name) && !topic.whoShouldMeditate.isEmpty
    }

    // MARK: - WhoShouldMeditate button
    private var whoShouldMeditateLink: some View {
        NavigationLink {
            WhoShouldMeditateView(
                topicName: topic.name,
                content: topic.whoShouldMeditate
            )
        } label: {
            HStack(spacing: 8) {
                Image(systemName: "info.circle")
                    .foregroundColor(.secondary)

                Text("Who should meditate on this topic")
                    .font(.footnote)
                    .foregroundColor(.secondary)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            .padding(.top, 8)
        }
        .buttonStyle(.plain)
    }

    var body: some View {
        VStack(spacing: 16) {

            // MARK: WhoShouldMeditate above title
            if shouldShowDescriptionButton {
                whoShouldMeditateLink
            }

            // MARK: Header
            VStack(alignment: .leading, spacing: 6) {
                Text(topic.name)
                    .font(.title2)
                    .fontWeight(.bold)

                Text("Decade \(currentDecade)")
                    .font(.headline)
                    .foregroundColor(.secondary)

                if let mysterySubtitle {
                    Text(mysterySubtitle)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)

            // MARK: Verses
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {

                        // 👇 invisible anchor at the very top
                        Color.clear
                            .frame(height: 1)
                            .id(scrollTopID)
                        
                        // 🙏 Our Father (once per decade)
                                   Text("Our Father…")
                                       .font(font)
                                       .italic()
                                       .padding(.bottom, 8)
                                       .foregroundColor(.secondary)

                                   Divider()

                        ForEach(verses) { verse in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(verse.verse)
                                    .font(font)

                                Text("Hail Mary…")
                                    .font(font)
                                    .italic()
                                    .foregroundColor(.secondary)

                                Divider()
                            }
                        }
                        // ✨ Glory Be (once per decade, after last Hail Mary)
                                   Text("Glory be…")
                                       .font(font)
                                       .italic()
                                       .padding(.top, 8)
                                       .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                }
                // 👇 react to decade change
                .onChange(of: currentDecade) {
                    withAnimation {
                        proxy.scrollTo(scrollTopID, anchor: .top)
                    }
                }

            }
            Spacer()

            // MARK: Bottom Navigation Buttons
            HStack(spacing: 12) {

                // Previous Decade (hidden on Decade 1)
                if currentDecade > 1 {
                    Button {
                        withAnimation { currentDecade -= 1 }
                    } label: {
                        Text("Decade \(currentDecade - 1)")
                            .font(font)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color(.systemBackground))
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.secondary.opacity(0.4), lineWidth: 1)
                            )
                            .foregroundColor(.primary)
                    }
                }

                // Next Decade / Closing Prayers
                Button {
                    withAnimation {
                        if currentDecade < maxDecades {
                            currentDecade += 1
                        } else {
                            navigateToClosingPrayers = true
                        }
                    }
                } label: {
                    Text(currentDecade < maxDecades
                         ? "Decade \(currentDecade + 1)"
                         : "Closing Prayers")
                        .font(font)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color.accentColor.opacity(0.12))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color.accentColor.opacity(0.5), lineWidth: 1)
                        )
                        .foregroundColor(Color.accentColor)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .navigationBarTitleDisplayMode(.inline)
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
        // MARK: iOS 16+ Navigation to Closing Prayers
        .navigationDestination(isPresented: $navigateToClosingPrayers) {
            ClosingPrayersView()
        }
    }
}

#Preview {
    let mockVerses = [
        RosaryVerse(verse: "The angel Gabriel was sent to Mary…", decade: 1),
        RosaryVerse(verse: "Mary said yes to God’s will…", decade: 1),
        RosaryVerse(verse: "Mary visited Elizabeth…", decade: 2),
        RosaryVerse(verse: "John leapt in the womb…", decade: 2),
        RosaryVerse(verse: "Jesus was born in Bethlehem…", decade: 3),
        RosaryVerse(verse: "The shepherds rejoiced…", decade: 3),
        RosaryVerse(verse: "Jesus was presented in the Temple…", decade: 4),
        RosaryVerse(verse: "Simeon praised God…", decade: 4),
        RosaryVerse(verse: "Jesus was found in the Temple…", decade: 5),
        RosaryVerse(verse: "Mary treasured all these things…", decade: 5)
    ]

    let mockMysteries = [
        RosaryMystery(topic: "Joyful Mysteries", decade: 1, mystery: "The Annunciation"),
        RosaryMystery(topic: "Joyful Mysteries", decade: 2, mystery: "The Visitation"),
        RosaryMystery(topic: "Joyful Mysteries", decade: 3, mystery: "The Nativity"),
        RosaryMystery(topic: "Joyful Mysteries", decade: 4, mystery: "The Presentation"),
        RosaryMystery(topic: "Joyful Mysteries", decade: 5, mystery: "The Finding of the Child Jesus in the Temple")
    ]

    NavigationStack {
        RosaryDetailView(
            topic: Topic(name: "Anger", jsonFileName: "anger", whoShouldMeditate: "Yet you must go on steadily in all those things that you have learned…"),
            loadedVerses: mockVerses,
            loadedMysteries: mockMysteries
        )
    }
}
