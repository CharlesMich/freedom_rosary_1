//
//  ClosingPrayersView.swift
//  freedom_rosary
//
//  Created by Charles Michael on 12/26/25.
//

import SwiftUI

struct ClosingPrayersView: View {

    @Environment(\.colorScheme) var colorScheme

    @AppStorage(AppStorageKeys.fontSize)
    private var fontSizeRaw: String = FontSize.small.rawValue

    private var fontSize: FontSize {
        FontSettings.font(from: fontSizeRaw)
    }

    // MARK: - Placeholder Content (replace later)
    private let prayers: [String] = [
        "Hail, holy Queen, mother of mercy, our life, our sweetness, and our hope. To thee do we cry, poor banished children of Eve. To thee do we send up our sighs mourning and weeping in this valley of tears. Turn then, most gracious advocate, thine eyes of mercy toward us, and after this our exile show us the blessed fruit of thy womb, Jesus. O clement, O loving, O sweet Virgin Mary.",
        "Pray for us, O Holy Mother of God. That we may be made worthy of the promises of Christ.",
        "Let us pray, O God, whose only begotten Son, by His life, death, and resurrection, has purchased for us the rewards of eternal salvation. Grant, we beseech Thee, that while meditating on these mysteries of the most holy Rosary of the Blessed Virgin Mary, that we may both imitate what they contain and obtain what they promise, through Christ our Lord. Amen.",
        "Most Sacred Heart of Jesus, have mercy on us.Immaculate Heart of Mary, pray for us.",
        "In the name of the Father, and of the Son, and of the Holy Spirit. Amen.",
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                ForEach(prayers.indices, id: \.self) { index in
                    Text(prayers[index])
                        .font(fontSize.font)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
            }
            .padding()
        }
        .navigationTitle("Closing Prayers")
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

struct ClosingPrayersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ClosingPrayersView()
        }
        .preferredColorScheme(.light)

        NavigationStack {
            ClosingPrayersView()
        }
        .preferredColorScheme(.dark)
    }
}

