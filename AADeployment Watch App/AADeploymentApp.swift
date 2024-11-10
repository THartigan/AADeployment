//
//  AADeploymentApp.swift
//  AADeployment Watch App
//
//  Created by Thomas Hartigan on 25/09/2024.
//

import SwiftUI
import SwiftData

@main
struct AADeployment_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            LandingView()
        }
        .modelContainer(for: [Alarm.self])
    }
}
