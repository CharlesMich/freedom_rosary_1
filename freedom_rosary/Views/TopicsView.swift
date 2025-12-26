//
//  TopicsView.swift
//  freedom_rosary
//
//  Created by Charles Michael on 12/23/25.
//

import SwiftUI

struct TopicRow: View {
    let topic: Topic
    let font: Font
    let color: Color

    var body: some View {
        VStack(spacing: 0) {
            NavigationLink {
                RosaryDetailView(title: topic.name, fileName: topic.jsonFileName)
            } label: {
                Text(topic.name)
                    .font(font)
                    .fontWeight(.regular)
                    .foregroundColor(color)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            Divider()
                .background(color)
        }
    }
}


struct TopicsView: View {

    private let topics: [Topic]

    init(topics: [Topic] = TopicLoader.load()) {
        self.topics = topics
    }

    @Environment(\.colorScheme) var colorScheme

    @AppStorage(AppStorageKeys.fontSize)
    private var fontSizeRaw: String = FontSize.small.rawValue

    private var fontSize: FontSize {
        FontSettings.font(from: fontSizeRaw)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(topics) { topic in
                        TopicRow(
                            topic: topic,
                            font: fontSize.font,
                            color: colorScheme == .dark ? .white : .black
                        )
                    }
                }
                .background(colorScheme == .dark ? Color.black : Color.white)
            }
            .navigationTitle("Topics")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // Cycle through font sizes
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
                            .frame(width: 28, height: 28)
                    }
                }
            }
        }
    }
}

struct TopicsView_Previews: PreviewProvider {
    static var previews: some View {
        let mockTopics = [
            Topic(name: "Joyful Mysteries", jsonFileName: "joyful"),
            Topic(name: "Sorrowful Mysteries", jsonFileName: "sorrowful"),
            Topic(name: "Glorious Mysteries", jsonFileName: "glorious")
        ]
        
        return Group {
            TopicsView(topics: mockTopics)
                .preferredColorScheme(.light)
            
            TopicsView(topics: mockTopics)
                .preferredColorScheme(.dark)
        }
    }
}
