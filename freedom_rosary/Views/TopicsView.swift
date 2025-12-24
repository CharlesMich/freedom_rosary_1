//
//  TopicsView.swift
//  freedom_rosary
//
//  Created by Charles Michael on 12/23/25.
//

import SwiftUI

struct TopicsView: View {

    private let topics: [Topic] = TopicLoader.load()

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
                        NavigationLink {
                            // Replace with VersionView / DetailView when ready
                            Text("\(topic.name) Content Here")
                                .font(fontSize.font)
                        } label: {
                            Text(topic.name)
                                .font(fontSize.font)
                                .fontWeight(.regular)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }

                        Divider()
                            .background(colorScheme == .dark ? Color.white : Color.black)
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
        Group {
            TopicsView()
                .preferredColorScheme(.light)

            TopicsView()
                .preferredColorScheme(.dark)
        }
    }
}
