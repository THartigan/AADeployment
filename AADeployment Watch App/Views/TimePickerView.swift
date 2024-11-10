//
//  TimePickerView.swift
//  AADeployment Watch App
//
//  Created by Thomas Hartigan on 26/09/2024.
//

import SwiftUI

struct TimePickerView: View {
    var requestString: String
    @Binding var selectedTime: Date
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                Text(requestString)
                DatePicker("Select Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                Button("Done") {
                    dismiss()
                }
            }
            
            
            
        }
    }
}

