//
//  LandingView.swift
//  AADeployment Watch App
//
//  Created by Thomas Hartigan on 25/09/2024.
//

import SwiftUI
import SwiftData

struct LandingView: View {
    @Query var alarm: [Alarm]
    
    var body: some View {
        NavigationView {
            ZStack{
                // Gradient Background
                BackgroundView()
                
                VStack{
                    NavigationLink {
                        EditAlarmView()
                        
                    } label: {
                        Text("Edit Alarm")
                    }
                    Text("Next: None")
                    NavigationLink {
                        SleepView()
                    } label: {
                        Text("Sleep Now")
                    }

                }
                .navigationTitle("Active Alarm")
            }
        }
        
    }
}
