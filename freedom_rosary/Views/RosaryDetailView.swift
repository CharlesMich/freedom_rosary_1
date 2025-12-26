//
//  RosaryDetailView.swift
//  freedom_rosary
//
//  Created by Charles Michael on 12/24/25.
//

//
//  RosaryDetailView.swift
//  freedom_rosary
//
//  Created by Charles Michael on 12/24/25.
//

import SwiftUI

struct RosaryDetailView: View {

    let title: String
    let fileName: String
    var loadedVerses: [RosaryVerse]? = nil
    var loadedMysteries: [RosaryMystery]? = nil   // 👈 for preview

    @State private var currentDecade: Int = 1
    private let maxDecades = 5

    // Font size
    @AppStorage(AppStorageKeys.fontSize) private var fontSizeRaw: String = FontSize.small.rawValue
    private var font: Font {
        FontSize(rawValue: fontSizeRaw)?.font ?? .body
    }

    // MARK: - Verses for current decade
    private var verses: [RosaryVerse] {
        let all = loadedVerses ?? RosaryLoader.load(fileName: fileName)
        return all.filter { $0.decade == currentDecade }
    }

    // MARK: - Mystery subtitle
    private var mysterySubtitle: String? {
        let mysteries = loadedMysteries ?? RosaryMysteryLoader.load()
        return mysteries.first {
            $0.topic == title && $0.decade == currentDecade
        }?.mystery
    }


    var body: some View {
        
        VStack(spacing: 16) {
            // MARK: Header
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
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
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
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
                }
                .padding(.horizontal)
            }

            Spacer()

            // MARK: Navigation Button
            Button {
                withAnimation {
                    if currentDecade < maxDecades {
                        currentDecade += 1
                    }
                }
            } label: {
                Text(currentDecade < maxDecades
                     ? "Move to Decade \(currentDecade + 1)"
                     : "Go to Closing Prayers")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(currentDecade < maxDecades ? Color.blue : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(14)
            }
            .padding(.horizontal)
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
            title: "Joyful Mysteries",
            fileName: "joyful",
            loadedVerses: mockVerses,
            loadedMysteries: mockMysteries
        )
    }
}

