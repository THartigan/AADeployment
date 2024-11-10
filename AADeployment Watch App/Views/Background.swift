//
//  Background.swift
//  AADeployment Watch App
//
//  Created by Thomas Hartigan on 26/09/2024.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.blue, Color.purple]),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}


