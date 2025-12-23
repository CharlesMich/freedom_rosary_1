import SwiftUI

enum FontSize: String, CaseIterable {
    case small, medium, large
    
    var font: Font {
        switch self {
        case .small: return .body
        case .medium: return .title3
        case .large: return .title2
        }
    }
    
    var scale: CGFloat {
        switch self {
        case .small: return 1.0
        case .medium: return 1.2
        case .large: return 1.4
        }
    }
}

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
    @AppStorage("notesFontSize") private var fontSizeRaw: String = FontSize.small.rawValue
    private var fontSize: FontSize {
        get { FontSize(rawValue: fontSizeRaw) ?? .small }
        set { fontSizeRaw = newValue.rawValue }
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
