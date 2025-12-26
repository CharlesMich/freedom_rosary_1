//
//  WhyToPrayRosaryView.swift
//  freedom_rosary
//
//  Created by Charles Michael on 12/25/25.
//

import SwiftUI

struct WhyToPrayRosaryView: View {

    @Environment(\.colorScheme) var colorScheme

    @AppStorage(AppStorageKeys.fontSize)
    private var fontSizeRaw: String = FontSize.small.rawValue

    private var fontSize: FontSize {
        FontSettings.font(from: fontSizeRaw)
    }

    private let reasons: [String] = [
        "The prayers of the Rosary are inspired from Scripture.",
        "We meditate on the life and ministry of Jesus.",
        "We are invoking the intercession of the Blessed Mother each time we recite the Rosary.",
        "We are invoking the protection of our Blessed Mother.",
        "We are seeking the intervention of our Blessed Mother.",
        "Our Blessed Mother will draw us close to Jesus and teach us to do His will."
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(reasons.indices, id: \.self) { index in
                    Text("• \(reasons[index])")
                        .font(fontSize.font)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
            }
            .padding()
        }
        .navigationTitle("Why Pray the Rosary")
        .navigationBarTitleDisplayMode(.large)
        .background(colorScheme == .dark ? Color.black : Color.white)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    cycleFontSize()
                } label: {
                    Image(systemName: "textformat")
                        .imageScale(.large)
                        .scaleEffect(FontSize(rawValue: fontSizeRaw)?.scale ?? 1.0)
                        .frame(width: 28, height: 28)
                }
            }
        }
    }

    // MARK: - Font Size Cycling

    private func cycleFontSize() {
        switch fontSizeRaw {
        case FontSize.small.rawValue:
            fontSizeRaw = FontSize.medium.rawValue
        case FontSize.medium.rawValue:
            fontSizeRaw = FontSize.large.rawValue
        default:
            fontSizeRaw = FontSize.small.rawValue
        }
    }
}

struct WhyToPrayRosaryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            WhyToPrayRosaryView()
        }
        .preferredColorScheme(.light)

        NavigationStack {
            WhyToPrayRosaryView()
        }
        .preferredColorScheme(.dark)
    }
}

