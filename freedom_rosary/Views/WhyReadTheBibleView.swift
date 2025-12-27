//
//  WhyReadTheBibleView.swift
//  freedom_rosary
//
//  Created by Charles Michael on 12/25/25.
//

import SwiftUI

struct WhyReadTheBibleView: View {

    @Environment(\.colorScheme) var colorScheme

    @AppStorage(AppStorageKeys.fontSize)
    private var fontSizeRaw: String = FontSize.small.rawValue

    private var fontSize: FontSize {
        FontSettings.font(from: fontSizeRaw)
    }

    // MARK: - Content Model (easy to extend later)
    private let sections: [(title: String, verse: String)] = [
        (
            title: "1. General Blessings",
            verse: "He who gazes upon the perfect law of liberty, and who remains in it, is not a forgetful hearer, but instead a doer who acts. He shall be blessed in what he does. (Jas 1:25)"
        ),
        (
            title: "2. God’s Word fills our spiritual appetite",
            verse: "Man shall not live by bread alone, but by every word that proceeds from the mouth of God. (Matt 4:4)"
        ),
        (
            title: "3. God’s Word can save us",
            verse: "Having cast away all uncleanness and an abundance of wickedness, receive with meekness the implanted Word, which is able to save your souls. (Jas 1:21)"
        ),
        (
            title: "4. The Word of God breaks our hardness (Unbelief, Blocks, Obstacles)",
            verse: "Is not my word like fire, says the Lord, and like a hammer that breaks a rock in pieces? (Jer 23:29)"
        ),
        (
            title: "5. The Word of God can reach the innermost person and reveal us our inner nature",
            verse: "The Word of God is living and effective: more piercing than any two-edged sword, reaching to the division even between the soul and the spirit, even between the joints and the marrow, and so it discerns the thoughts and intentions of the heart. (Heb 4:12)"
        ),
        (
            title: "6. God’s Word gives us direction and counsel ",
            verse: "Your word is a lamp to my feet and a light to my path. (Ps 119:105)"
        ),
        (
            title: "7. God’s Word teaches, reproofs, and corrects us",
            verse: "All Scripture, having been divinely inspired, is useful for teaching, for reproof, for correction, and for instruction in justice, so that the man of God may be perfect, having been trained for every good work. (2 Tim 3:16-17)"
        ),
        (
            title: "8. We receive emotional healing",
            verse: "The law of the Lord is perfect, reviving souls. The testimony of the Lord is faithful, providing wisdom to little ones; the justice of the Lord are right, rejoicing hearts; the precepts of the Lord is clear, enlightening the eyes. (Ps 19:7-8)"
        ),
        (
            title: "9.  We are filled with the Holy Spirit",
            verse: "Give heed to my reproof. Lo, I will offer my spirit to you, and I will reveal my words to you. (Pro 1:23)"
        ),
        (
            title: "10. We find freedom from sin and addictions ",
            verse: "I will always keep your law, in this age and forever and ever. I shall walk at liberty, because I was seeking your commandments. (Ps 119:44-45)"
        ),
        (
            title: "11. We receive direction and counsel in life",
            verse: "The book of this law shall not depart from your mouth. Instead, you shall meditate upon it, day and night, so that you may observe and do all the things that are written in it. Then you shall direct your way and understand it. (Josh 1:8)"
        ),
        (
            title: "12.  God’s promise of eternal life when we read the Bible",
            verse: "This is the book of the commandments of God and of the law, which exists in eternity. All those who keep it will attain to life, but those who have forsaken it, to death. (Bar 4:1)"
        ),
        (
            title: "13. God’s Word fills us with hope",
            verse: "Whatever was written, was written to teach us, so that, through patience and the consolation of the Scriptures, we might have hope. (Rom 15:4)"
        ),
        (
            title: "14. God’s Word increases our faith",
            verse: "Faith comes from what is heard, and what is heard comes through the word of Christ. (Rom 10:17)"
        ),
        (
            title: "15.  God’s Word comforts us in our distress",
            verse: "This is my comfort in my distress: for your promises gives me life. (Ps 119:50)"
        ),
        (
            title: "16. Deliverance from evil",
            verse: "He sent his word, and healed them, and delivered them from their destructions. (Ps 107:20)"
        ),
        (
            title: "17. We receive healing ",
            verse: "Indeed, neither an herb, nor a poultice, healed them, but your word, O Lord, which heals all. (Wis 16:12)"
        ),
        (
            title: "18. God’s Word fills us with joy",
            verse: "I discovered your words and I consumed them. And your word became to me as the gladness and joy of my heart. For your name has been invoked over me, O Lord, the God of hosts. (Jer 15:16)"
        ),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                ForEach(sections.indices, id: \.self) { index in
                    VStack(alignment: .leading, spacing: 12) {

                        // Headline
                        Text(sections[index].title)
                            .font(fontSize.font.weight(.semibold))
                            .foregroundColor(colorScheme == .dark ? .white : .black)

                        // Bible Verse
                        Text(sections[index].verse)
                            .font(fontSize.font)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .padding(.leading, 12)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Why Read the Bible")
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

struct WhyReadTheBibleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            WhyReadTheBibleView()
        }
        .preferredColorScheme(.light)

        NavigationStack {
            WhyReadTheBibleView()
        }
        .preferredColorScheme(.dark)
    }
}

