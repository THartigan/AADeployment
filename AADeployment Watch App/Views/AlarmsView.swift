//
//  AlarmsView.swift
//  AADeployment Watch App
//
//  Created by Thomas Hartigan on 25/09/2024.
//

import SwiftUI

//struct AlarmsView: View {
//    @State var alarms: [Alarm] = []
//    var body: some View {
//        NavigationView {
//            ZStack{
//                // Gradient Background
//                LinearGradient(
//                    gradient: Gradient(colors: [Color.blue, Color.purple]),
//                    startPoint: .top,
//                    endPoint: .bottom
//                )
//                .ignoresSafeArea()
//                ScrollView {
//                    ForEach(alarms) { alarm in
//                        NavigationLink {
//                            EditAlarmView()
//                        } label: {
//                            Text(alarm.time?.description ?? "N/A")
//                        }
//                    }
//                    NavigationLink {
//                        EditAlarmView(alarm: Alarm())
//                    } label: {
//                        Text("Alarms")
//                    }
//                }
//                .navigationTitle("Alarms")
//            }
//        }
//    }
//}
