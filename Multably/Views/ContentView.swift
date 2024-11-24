//
//  ContentView.swift
//  Multably
//
//  Created by Saverio Negro on 23/11/24.
//

import SwiftUI

extension Date {
    func getDayNameOfWeek() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "eeee"
        return formatter.string(from: self)
    }
    
    func getTime() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: self)
    }
}

struct ContentView: View {
    
    @State private var quantity = 1
    @State private var deliveryTime = Date()
    @State private var groceryList = [String]()
    @State private var isTapped = false
    @State private var word = ""
    @State private var isCorrect = true
    
    var deliveryStartTime: Date {
        var components = Calendar.current.dateComponents(Set([.year, .month, .day, .hour, .minute]), from: deliveryTime)
        
        components.hour = 19
        components.minute = 0
        
        return Calendar.current.date(from: components) ?? .now
    }
    
    var deliveryEndTime: Date {
        var components = Calendar.current.dateComponents(Set([.year, .month, .day, .hour, .minute]), from: deliveryTime)
        
        components.hour = 23
        components.minute = 0
        
        return Calendar.current.date(from: components) ?? .now
    }
    
    var deliveryDateString: String {
        return deliveryTime.getDayNameOfWeek()
    }
    
    var deliveryTimeString: String {
        return deliveryTime.getTime()
    }
    
    func getGroceryList() -> [String]? {
        if let fileURL = Bundle.main.url(forResource: "grocery_list", withExtension: "txt") {
            if let fileContents = try? String(contentsOf: fileURL, encoding: .utf8) {
                return fileContents.components(separatedBy: "\n")
            }
        }
        return nil
    }
    
    func isWordMispelled(word: String) -> Bool {
        let checker = UITextChecker()
        
        let range = NSRange(location: 0, length: word.utf16.count)
        
        let mispelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        if mispelledRange.location == NSNotFound {
            return false
        }
        
        return true
    }
    
    var body: some View {
        VStack {
            Form {
                Section("How many pizzas?") {
                    Stepper("^[\(quantity) pizza](inflect: true)", value: $quantity, in: 1...10)
                }
                
                Section("When do you want the delivery?") {
                    DatePicker("Delivery Time", selection: $deliveryTime, in: deliveryStartTime...deliveryEndTime, displayedComponents: .hourAndMinute)
                }
                
                Text("You selected ^[\(quantity) pizza](inflect: true) to be delivered on \(deliveryDateString) at \(deliveryTimeString).")
                
                TextField("Enter your word", text: $word)
                Text("Your word is \(isWordMispelled(word: word) ? "incorrect" : "correct")")
            }
            .scrollDisabled(true)
            
            List {
                ForEach(groceryList, id: \.self) { item in
                    Text(item)
                }
                .onDelete { indexOffset in
                    groceryList.remove(atOffsets: indexOffset)
                }
            }
        }
        
        .onAppear {
            deliveryTime = deliveryStartTime
            if let groceries = getGroceryList() {
                groceryList = groceries
            }
        }
    }
}

#Preview {
    ContentView()
}
