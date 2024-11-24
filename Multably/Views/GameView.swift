//
//  GameView.swift
//  Multably
//
//  Created by Saverio Negro on 24/11/24.
//

import SwiftUI

struct GameView: View {
    
    var settings: Settings
    @State private var question = "Some question"
    @State private var playerAnswer = ""
    @State private var isGameActive = false
    
    var body: some View {
        VStack() {
            
            // Go to settings view
            
        }
        .padding()
        .toolbar {
            ToolbarItem(id: "Settings", placement: .topBarTrailing) {
                NavigationLink(destination: SettingsView(settings: settings)) {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
        }
    }
}

#Preview {
    GameView(settings: Settings())
}
