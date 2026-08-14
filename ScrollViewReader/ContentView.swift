//
//  ContentView.swift
//  ScrollViewReader
//
//  Created by Anurag on 14/08/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var text = ""
    @State private var indexValue: Int = 0
    
    var body: some View {
        VStack {
            
            TextField("Enter text", text: $text)
                .frame(height: 55.0)
                .border(.gray)
                .padding()
                .keyboardType(.numberPad)
            
            Button("Scroll Now!!!") {
                withAnimation(.spring()) {
                    if let index = Int(text) {
                        indexValue = index
                    }
                }
            }
            ScrollView {
                ScrollViewReader { proxy in
                    ForEach(0..<150, id: \.self) { index in
                        Text("This is item at index: \(index)")
                            .font(.title)
                            .fontWeight(.medium)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding()
                            .id(index) // 👈 Important: give each item an id
                    }
                    .onChange(of: indexValue) { oldValue, newValue in
                        withAnimation(.spring()) {
                            proxy.scrollTo(newValue, anchor: .center)
                        }
                    }
                }
                .padding()
            }
            
        }
    }
}

#Preview {
    ContentView()
}
