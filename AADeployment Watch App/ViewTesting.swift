//
//  ViewTesting.swift
//  AADeployment Watch App
//
//  Created by Thomas Hartigan on 25/09/2024.
//

import SwiftUI

struct ViewTesting: View {
    @State private var trigger = false
    var body: some View {
        ZStack{
            // Gradient Background
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // Background SF Symbol
            Image(systemName: "figure.core.training")
                .resizable()
                .scaledToFit()
                .opacity(0.1)
            
            // Foreground Content
            VStack {
                Text("Situp Counter")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text("\(Int(2)) Counted")
                Spacer()
                Button {
                    trigger.toggle()
                    trigger ? stop() : start()
                } label: {
                    Text(trigger ? "Stop" : "Start")
                }

                // Additional UI elements
            }
        }
    }
    
    func start() {
        
    }
    
    func stop() {
        
    }
}

#Preview {
    ViewTesting()
}
