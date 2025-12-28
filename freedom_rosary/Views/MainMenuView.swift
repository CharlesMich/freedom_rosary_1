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

                    NavigationLink {
                        AppsView()
                    } label: {
                        rowView(title: "Apps")
                    }
                    divider()

                    NavigationLink {
                        EbooksView(platform: .kindle)
                    } label: {
                        rowView(title: "Ebooks (Kindle)")
                    }
                    divider()

                    NavigationLink {
                        EbooksView(platform: .appleBooks)
                    } label: {
                        rowView(title: "Ebooks (Apple Books)")
                    }
                    divider()

                    NavigationLink {
                        PaperbackView()
                    } label: {
                        rowView(title: "Paperback")
                    }
                    divider()
                    externalLink(
                        title: "Amazon Author Page",
                        url: "https://www.amazon.com/stores/Charles-Michael/author/B07SMB94PD"
                    )

                    externalLink(
                        title: "Visit Our Website",
                        url: "https://giftedbookstore.com"
                    )

                    NavigationLink {
                        CopyrightView()
                    } label: {
                        rowView(title: "Copyright")
                    }
                    divider()
                }
                .background(colorScheme == .dark ? .black : .white)
            }
            .navigationTitle("Main Menu")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { cycleFontSize() } label: {
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

    private func rowView(title: String) -> some View {
        Text(title)
            .font(fontSize.font)
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func divider() -> some View {
        Divider()
            .background(colorScheme == .dark ? Color.white : Color.black)
    }

    private func externalLink(title: String, url: String) -> some View {
        VStack(spacing: 0) {
            Link(destination: URL(string: url)!) {
                rowView(title: title)
            }
            divider()
        }
    }

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
