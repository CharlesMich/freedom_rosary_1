//
//  WhoShouldMeditateView.swift
//  freedom_rosary
//
//  Created by Charles Michael on 12/28/25.
//

import SwiftUI

struct WhoShouldMeditateView: View {
    let topicName: String
    let content: String

    // Font size support
    @AppStorage(AppStorageKeys.fontSize)
    private var fontSizeRaw: String = FontSize.small.rawValue

    private var font: Font {
        FontSize(rawValue: fontSizeRaw)?.font ?? .body
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                // Title
                Text("Who Should Meditate on Scriptures about \(topicName)")
                    .font(.title3)
                    .fontWeight(.semibold)

                Divider()

                // Body text
                Text(content)
                    .font(font)
                    .multilineTextAlignment(.leading)

                Spacer(minLength: 24)
            }
            .padding()
        }
        .navigationTitle("Meditation")
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
                        .frame(width: 28, height: 28)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        WhoShouldMeditateView(
            topicName: "Anger",
            content: """
            Yet you must go on steadily in all those things that you have learned and which you know are true...
            """
        )
    }
}

