//
//  EbooksView.swift
//  freedom_rosary
//
//  Created by Charles Michael on 12/27/25.
//

import SwiftUI

enum EbookPlatform: Hashable {
    case kindle
    case appleBooks
}

struct EbooksItem: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let description: String
    let platforms: Set<EbookPlatform>
}

struct EbooksView: View {

    let platform: EbookPlatform

       @Environment(\.colorScheme) private var colorScheme

       @AppStorage(AppStorageKeys.fontSize)
       private var fontSizeRaw: String = FontSize.small.rawValue

       private var fontSize: FontSize {
           FontSettings.font(from: fontSizeRaw)
       }
    // MARK: - Placeholder App Data (expand later)
    private let ebooks: [EbooksItem] = [
        EbooksItem(
            title: "God's Promises and Blessings for an Abundant Life",
            imageName: "bp_ebook",
            description: "This book makes a sincere effort to bring out God's promises and blessings in the Bible and organizes it under various topics that are relevant to our times and need.",
            platforms: [.kindle, .appleBooks]
        ),
        EbooksItem(
            title: "Children's Examination of Conscience",
            imageName: "c_eoc_ebook",
            description: "The only book you will need as a parent, to teach the commandments to your child. It is designed in a simple question format that can be easily read and understood by a child.",
            platforms: [.kindle]
        ),
        EbooksItem(
            title: "30 Reasons to go to Confession",
            imageName: "confession_ebook",
            description: "This book brings out the beauty and the Power of the Sacrament of Reconciliation by taking us through a journey into one of God's greatest miracles in the form of a Sacrament. ",
            platforms: [.kindle]
        ),
        EbooksItem(
            title: "Eucharistic Adoration",
            imageName: "ea_ebook",
            description: "Prayers, devotions, and meditations to help us focus on God while we are adoring Jesus in the Blessed Sacrament.",
            platforms: [.kindle]
        ),
        EbooksItem(
            title: "Examination of Conscience",
            imageName: "eoc_ebook",
            description: "This book covers a thorough and complete examination of conscience based on the Ten Commandments.",
            platforms: [.kindle]
        ),
        EbooksItem(
            title: "Freedom from Porn and Masturbation",
            imageName: "ffpam_ebook",
            description: "The author takes us on a journey of self-examination in tracing and identifying the root cause or causes of our addictions and sinful tendencies and in the process guides us to a lasting solution to our addictions.",
            platforms: [.kindle]
        ),
        EbooksItem(
            title: "Godly Child",
            imageName: "gc_ebook",
            description: "A handbook for children aged between 6 and 12 teaching them about their relationship with God and people. This book is aimed to foster godly qualities in a child while also introducing the duties and responsibilities which will educate them of what God expects from them.",
            platforms: [.kindle]
        ),
        EbooksItem(
            title: "Preacher's Handbook",
            imageName: "ph_ebook",
            description: "A Collection of Bible Verses for Sermons, Retreat Preachings, and Homilies. Includes over 5,000 Bible Verses and References from the Catechism. A must have reference guide for Priests, Lay preachers, Evangelists. Retreat preachers, Apologists.",
            platforms: [.kindle]
        ),
        EbooksItem(
            title: "Return to God",
            imageName: "rtg_ebook",
            description: "A complete guide to the Sacrament of Reconciliation with a thorough examination of conscience. It is supported with over 900 references from the Holy Bible and other Catholic resources.",
            platforms: [.kindle]
        ),
        EbooksItem(
            title: "Scriptural Rosary",
            imageName: "sr_ebook",
            description: "Includes the 4 traditional mysteries and with over 1000 verses, covers a range of spiritiual topics to meditate on.",
            platforms: [.kindle]
        ),
        EbooksItem(
            title: "Scriptural Stations of the Cross",
            imageName: "ssotc_ebook",
            description: "Includes the traditional Way of the Cross and two forms of scriptural Stations and other meditations on the passion of Christ.",
            platforms: [.kindle]
        ),
        EbooksItem(
            title: "To Jesus with Mary",
            imageName: "tjim_ebook",
            description: "Meditate on the life and ministry of Jesus Christ while praying the Rosary. Includes the four traditional mysteries with scriptures.",
            platforms: [.kindle]
        ),
        EbooksItem(
            title: "Examination of Conscience for Teens",
            imageName: "y_eoc_ebook",
            description: "This book includes a thorough and complete examination ofconscience for teens between 13 and 19 years old, based on theTen Commandments. It is designed in a question format that is easy to understand and prepare for confession.",
            platforms: [.appleBooks]
        ),
        
    ]
    
    private var filteredEbooks: [EbooksItem] {
        ebooks.filter { $0.platforms.contains(platform) }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {

                ForEach(filteredEbooks) { app in
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
                                .multilineTextAlignment(.center)
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
        .navigationTitle(platformTitle)
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

    private var platformTitle: String {
            platform == .kindle ? "Ebooks (Kindle)" : "Ebooks (Apple Books)"
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


#Preview {
    Group {
        NavigationStack {
            EbooksView(platform: .kindle)
        }
        .preferredColorScheme(.light)

        NavigationStack {
            EbooksView(platform: .appleBooks)
        }
        .preferredColorScheme(.dark)
    }
}


