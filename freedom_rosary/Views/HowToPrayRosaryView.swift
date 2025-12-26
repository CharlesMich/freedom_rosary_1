import SwiftUI

struct HowToPrayRosaryView: View {

    @Environment(\.colorScheme) var colorScheme

    @AppStorage(AppStorageKeys.fontSize)
    private var fontSizeRaw: String = FontSize.small.rawValue

    private var fontSize: FontSize {
        FontSettings.font(from: fontSizeRaw)
    }

    private let steps: [String] = [
        "Make the Sign of the Cross",
        "Say the “Apostles’ Creed”",
        "Say the “Our Father”",
        "Say three “Hail Marys” for Faith, Hope, and Charity",
        "Say the “Glory Be”",
        "Announce the First Mystery and then say the “Our Father”",
        "Say ten “Hail Marys” while meditating on the Mystery",
        "(If saying the Scriptural Rosary, read the scripture verse before each Hail Mary)",
        "Say the “Glory Be”",
        "Say the “O My Jesus” prayer requested by Mary at Fatima",
        "Announce the Next Mystery; then say the “Our Father” and repeat the steps",
        "Say the closing prayers: the “Hail Holy Queen” and the “Final Prayer”",
        "Make the Sign of the Cross"
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(steps.indices, id: \.self) { index in
                    Text("\(index + 1). \(steps[index])")
                        .font(fontSize.font)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
            }
            .padding()
        }
        .navigationTitle("How to Pray the Rosary")
        .navigationBarTitleDisplayMode(.large)
        .background(colorScheme == .dark ? Color.black : Color.white)
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

struct HowToPrayRosaryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HowToPrayRosaryView()
        }
        .preferredColorScheme(.light)

        NavigationStack {
            HowToPrayRosaryView()
        }
        .preferredColorScheme(.dark)
    }
}
