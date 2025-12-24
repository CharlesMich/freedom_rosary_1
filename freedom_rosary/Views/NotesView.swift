import SwiftUI

struct NotesView: View {
    private let links = [
        "How to pray the Rosary",
        "Why we should pray the Rosary",
        "Why should we read the Bible",
        "Prayers in the Rosary",
        "Closing Prayers",
        "Litany of the Blessed Virgin Mary"
    ]
    
    @Environment(\.colorScheme) var colorScheme
    
    
    @AppStorage(AppStorageKeys.fontSize)
    private var fontSizeRaw: String = FontSize.small.rawValue

    private var fontSize: FontSize {
        FontSettings.font(from: fontSizeRaw)
    }

    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(links.indices, id: \.self) { index in
                        NavigationLink(destination: Text("\(links[index]) Content Here").font(fontSize.font)) {
                            Text(links[index])
                                .font(fontSize.font)
                                .fontWeight(.regular)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        Divider()
                            .background(colorScheme == .dark ? Color.white : Color.black)
                    }
                }
                .background(colorScheme == .dark ? Color.black : Color.white)
            }
            .navigationTitle("Notes")
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
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NotesView()
                .preferredColorScheme(.light)
            
            NotesView()
                .preferredColorScheme(.dark)
        }
    }
}
