//
//  PaperbackView.swift
//  freedom_rosary
//
//  Created by Charles Michael on 12/27/25.
//

import SwiftUI

struct PaperbackView: View {
    @Environment(\.colorScheme) private var colorScheme

    @AppStorage(AppStorageKeys.fontSize)
    private var fontSizeRaw: String = FontSize.small.rawValue

    private var fontSize: FontSize {
        FontSettings.font(from: fontSizeRaw)
    }

    // MARK: - Placeholder App Data (expand later)
    private let apps: [PaperbackItem] = [
        PaperbackItem(
            title: "Eucharistic Adoration",
            imageName: "ea_paper",
            description: "Prayers, devotions, and meditations to help us focus on God while we are adoring Jesus in the Blessed Sacrament."
        ),
        PaperbackItem(
            title: "Family Prayer",
            imageName: "fp_paper",
            description: "An App to help us with our family prayer. It engages the whole family in simple and effective prayer. helps in teaching the children , the right way to pray."
        ),
        PaperbackItem(
            title: "Glory Be",
            imageName: "gb_paper",
            description: "A Free App with basic Catholic prayers and Bible verses to meditate."
        ),
        PaperbackItem(
            title: "Healing Prayer",
            imageName: "healing_paper",
            description: "A simple and effective way to seek God's healing. It includes  Bible verses to read and meditate"
        ),
        PaperbackItem(
            title: "To Jesus with Mary",
            imageName: "tjim_paper",
            description: "Meditate on the life and ministry of Jesus while praying the Rosary. Includes the four traditional mysteries with scriptures. "
        ),
        PaperbackItem(
            title: "Promise Rosary",
            imageName: "pr_paper",
            description: "Meditate on God's Promises from the Old and New Testament while praying the Rosary. Includes the four traditional mysteries with scriptures"
        ),
        PaperbackItem(
            title: "Scripture Rosary",
            imageName: "sr_paper",
            description: "Includes the 4 traditional mysteries and with over 1000 verses, covers a range of spiritiual topics to meditate on."
        ),
        PaperbackItem(
            title: "Scriptural Stations",
            imageName: "ssotc_paper",
            description: "Includes the traditional Way of the Cross and two forms of scriptural Stations and other meditations on the passion of Christ."
        ),
        
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {

                ForEach(apps) { app in
                    VStack(alignment: .leading, spacing: 16) {

                        
                        // Image
                        HStack {
                            Spacer()

                            Image(app.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: UIScreen.main.bounds.width * 0.25)
                                .cornerRadius(10)

                            Spacer()
                        }
                        // Title
                        HStack {
                            Spacer()
                            Text(app.title)
                                .font(fontSize.font)
                                .fontWeight(.semibold)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                            Spacer()
                        }

                        // Description
                        Text(app.description)
                            .font(fontSize.font)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .multilineTextAlignment(.center)
                        
                        // Faint Divider
                                               Divider()
                                                   .opacity(0.9)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Apps")
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

struct PaperbackItem: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let description: String
}

#Preview {
    PaperbackView()
}
