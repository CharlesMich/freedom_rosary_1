//
//  RosaryPrayersView.swift
//  freedom_rosary
//
//  Created by Charles Michael on 12/26/25.
//

import SwiftUI

struct RosaryPrayersView: View {

    @Environment(\.colorScheme) var colorScheme

    @AppStorage(AppStorageKeys.fontSize)
    private var fontSizeRaw: String = FontSize.small.rawValue

    private var fontSize: FontSize {
        FontSettings.font(from: fontSizeRaw)
    }

    // MARK: - Prayer Content (add more later)
    private let prayers: [(title: String, body: String)] = [
        (
            title: "The Apostles’ Creed",
            body: """
I believe in God,
the Father almighty,
Creator of heaven and earth,
and in Jesus Christ, his only Son, our Lord,
who was conceived by the Holy Spirit,
born of the Virgin Mary,
suffered under Pontius Pilate,
was crucified, died and was buried;
he descended into hell;
on the third day he rose again from the dead;
he ascended into heaven,
and is seated at the right hand of God the Father almighty;
from there he will come to judge the living and the dead.

I believe in the Holy Spirit,
the holy Catholic Church,
the communion of saints,
the forgiveness of sins,
the resurrection of the body,
and life everlasting.
Amen.
"""
        ),
        (title:"The Lord's Prayer",
         body:"""
         Our Father, who art in heaven,
         hallowed be thy name;
         thy kingdom come;
         thy will be done on earth as it is in heaven.
         Give us this day our daily bread;
         and forgive us our trespasses
         as we forgive those who trespass
         against us;
         and lead us not into temptation,
         but deliver us from evil.
         Amen
         """),
        (title:"The Hail Mary",
         body:"""
"Hail Mary, full of grace, the Lord is with you; blessed are you among women, and blessed is the fruit of your womb, Jesus.
Holy Mary, Mother of God, pray for us sinners now and at the hour of our death. Amen.
"""),
        (title:"The Glory Be",
         body:"Glory be to the Father, the Son, and the Holy Spirit; as it was in the beginning, is now, and ever shall be, world without end. Amen."),
        (title:"The Fatima Prayer",
         body:"O my Jesus, forgive us our sins, save us from the fires of hell, lead all souls to Heaven, especially those most in need of Thy mercy."),
        
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {

                ForEach(prayers.indices, id: \.self) { index in
                    VStack(alignment: .leading, spacing: 12) {

                        // Title
                        Text(prayers[index].title)
                            .font(fontSize.font.weight(.semibold))
                            .foregroundColor(colorScheme == .dark ? .white : .black)

                        // Body
                        Text(prayers[index].body)
                            .font(fontSize.font)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .padding(.leading, 8)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Rosary Prayers")
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

struct RosaryPrayersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RosaryPrayersView()
        }
        .preferredColorScheme(.light)

        NavigationStack {
            RosaryPrayersView()
        }
        .preferredColorScheme(.dark)
    }
}

