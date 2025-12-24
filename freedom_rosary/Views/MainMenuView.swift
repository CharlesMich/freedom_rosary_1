//
//  MainMenuView.swift
//  freedom_rosary
//
//  Created by Charles Michael on 12/23/25.
//
import SwiftUI

struct MainMenuView: View {

    @Environment(\.colorScheme) private var colorScheme

    @AppStorage(AppStorageKeys.fontSize)
    private var fontSizeRaw: String = FontSize.small.rawValue

    private var fontSize: FontSize {
        FontSettings.font(from: fontSizeRaw)
    }


    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {

                    externalLink(title: "Apps", url: "https://yourappslink.com")
                    externalLink(title: "Ebooks (Kindle)", url: "https://amazon.com/kindle-author-link")
                    externalLink(title: "Ebooks (Apple Books)", url: "https://books.apple.com/author-link")
                    externalLink(title: "Paperback (Amazon Store)", url: "https://amazon.com/your-paperbacks")
                    externalLink(title: "Amazon Author Page", url: "https://amazon.com/author-page")
                    externalLink(title: "Visit Our Website", url: "https://yourwebsite.com")

                    NavigationLink {
                        CopyrightView()
                    } label: {
                        rowView(title: "Copyright", isLink: true)
                    }

                    Divider()
                        .background(colorScheme == .dark ? Color.white : Color.black)
                }
                .background(colorScheme == .dark ? Color.black : Color.white)
            }
            .navigationTitle("Main Menu")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // 🔁 Cycle font sizes
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
                            .scaleEffect(fontSize.scale)
                            .frame(width: 28, height: 28)
                    }
                }
            }
        }
    }

    // MARK: - Helpers

    private func externalLink(title: String, url: String) -> some View {
        VStack(spacing: 0) {
            Link(destination: URL(string: url)!) {
                rowView(title: title, isLink: true)
            }

            Divider()
                .background(colorScheme == .dark ? Color.white : Color.black)
        }
    }

    private func rowView(title: String, isLink: Bool) -> some View {
        Text(title)
            .font(fontSize.font) // 🔤 APPLY FONT SIZE
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainMenuView()
                .preferredColorScheme(.light)

            MainMenuView()
                .preferredColorScheme(.dark)
        }
    }
}
