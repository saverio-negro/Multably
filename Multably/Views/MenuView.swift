//
//  MenuView.swift
//  Multably
//
//  Created by Saverio Negro on 24/11/24.
//

import SwiftUI

struct MenuView: View {
    
    var settings: Settings = Settings()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    NavigationLink("Play", destination: GameView(settings: settings))
                    
                    NavigationLink("Settings", destination: SettingsView(settings: settings))
                    
                    Button("Exit") {
                        
                    }
                }
            }
            .ignoresSafeArea()
            .navigationTitle("Multably")
        }
    }
}

#Preview {
    MenuView()
}
