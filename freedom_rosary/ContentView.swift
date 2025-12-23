//
//  ContentView.swift
//  freedom_rosary
//
//  Created by Charles Michael on 12/23/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {

            MainMenuView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Menu")
                }

            TopicsView()
                .tabItem {
                    Image(systemName: "list.bullet.rectangle")
                    Text("Topics")
                }

            NotesView()
                .tabItem {
                    Image(systemName: "note.text")
                    Text("Notes")
                }

            FavoritesView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorites")
                }
        }
    }
}

#Preview {
    ContentView()
}
