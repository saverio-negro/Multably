//
//  SettingsView.swift
//  Multably
//
//  Created by Saverio Negro on 24/11/24.
//

import SwiftUI

struct SettingsView: View {
    
    let numQuestions = [5, 10, 20]
    @State private var selectedNumQuestions = 5
    @State private var selectedTable = 2
    
    var body: some View {
        
        Form {
            
            Section("Multiplication Table") {
                Stepper("\(selectedTable) Times Table", value: $selectedTable, in: 2...12)
            }
            
            Section("Number of questions") {
                Picker("Number of questions", selection: $selectedNumQuestions) {
                    ForEach(numQuestions, id: \.self) { num in
                        Text("\(num)")
                    }
                }
                .pickerStyle(.segmented)
            }
        }
    }
}

#Preview {
    SettingsView()
}
