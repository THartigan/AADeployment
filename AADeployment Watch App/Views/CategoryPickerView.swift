//
//  CategoryPickerView.swift
//  AADeployment Watch App
//
//  Created by Thomas Hartigan on 26/09/2024.
//

import SwiftUI

struct CategoryPickerView<T: Hashable>: View {
    var requestString: String
    var pickerString: String
    var objects: [T]
    @Binding var selectedObject: T
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            BackgroundView()
            
            ScrollView {
                VStack{
                    Text(requestString)
                    Picker(pickerString, selection: $selectedObject) {
                        ForEach(objects, id:\.self) { object in
                            Text("\(object)").tag(object)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(minHeight: 50)
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            
            
        }
    }
}

