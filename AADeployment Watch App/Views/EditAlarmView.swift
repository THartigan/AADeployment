//
//  AddAlarmView.swift
//  AADeployment Watch App
//
//  Created by Thomas Hartigan on 25/09/2024.
//

import SwiftUI
import SwiftData

struct EditAlarmView: View {
    @Query(sort: \Alarm.time) var alarms: [Alarm]
    @Environment(\.modelContext) private var context
    @State private var alarmTime = Date()
    @State private var alarmWindow = 0
    @State private var workoutType = "Situps"
    @State private var sound = "none"
    @State private var bedTime = Date()
    private var workouts = ["Situps"]
    private var sounds = ["none"]
    let hhmmFormatter = DateFormatter()
    @Environment(\.dismiss) var dismiss
    @State private var noAlarmData = true
//    let alarm = Alarm(id: UUID(), time: Date.now, timeRange: 0, workoutType: WorkoutType.situp, sound: "none")
    var body: some View {
        ZStack {
            BackgroundView()
            ScrollView {
                VStack {
                    Text("Edit Alarm")
                    
                    NavigationLink {
                        TimePickerView(requestString: "Select desired alarm time", selectedTime: $alarmTime)
                    } label: {
                        Text("Alarm Time: \(hhmmFormatter.string(from: alarmTime))")
                    }
                    
                    NavigationLink {
                        CategoryPickerView(requestString: "Select desired alarm window. This is the period in minutes either side of your alarm time where the alarm may sound if you are sleeping lightly.",
                                           pickerString: "Alarm Window", objects: Array(0..<46), selectedObject: $alarmWindow)
                    } label: {
                        Text("Alarm Window: \(alarmWindow) mins")
                    }
                    
                    NavigationLink {
                        CategoryPickerView(requestString: "Select wakeup activity. This is the activity you must complete to turn off your alarm.",
                                           pickerString: "Activity Type", objects: workouts, selectedObject: $workoutType)
                    } label: {
                        Text("Wakeup Activity: \(workoutType)")
                    }
                    
                    NavigationLink {
                        CategoryPickerView(requestString: "Select wakeup sound.",
                                           pickerString: "Wakeup Sound", objects: sounds, selectedObject: $sound)
                    } label: {
                        Text("Wakeup Sound: \(sound)")
                    }
                        
                    NavigationLink {
                        TimePickerView(requestString: "Select target bedtime", selectedTime: $bedTime)
                    } label: {
                        Text("Bedtime: \(hhmmFormatter.string(from: bedTime))")
                    }
                    
                    Button("Save Alarm") {
                        let newAlarm = Alarm(time: alarmTime, timeRange: alarmWindow, workoutType: workoutType, sound: sound, bedTime: bedTime)
                        if alarms.count == 0 {
                            context.insert(newAlarm)
                        }
                        
                        do {
                            try context.save() // Save to persistent store
                        } catch {
                            print("Failed to save alarm: \(error)")
                        }
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            if alarms.count > 0 {
                print("Existing alarm loaded")
                noAlarmData = false
                let existingAlarm = alarms[0]
                alarmTime = existingAlarm.time
                alarmWindow = existingAlarm.timeRange
                workoutType = existingAlarm.workoutType
                sound = existingAlarm.sound
                bedTime = existingAlarm.bedTime
            } else if noAlarmData == true {
                let calendar = Calendar.current
                let today = Date()
                var alarmDateComponents = calendar.dateComponents([.year, .month, .day], from: today)
                alarmDateComponents.hour = 7
                alarmDateComponents.minute = 0
                alarmDateComponents.second = 0
                alarmTime = calendar.date(from: alarmDateComponents) ?? Date.now
                var bedTimeDateComponents = calendar.dateComponents([.year, .month, .day], from: today)
                bedTimeDateComponents.hour = 23
                bedTimeDateComponents.minute = 0
                bedTimeDateComponents.second = 0
                bedTime = calendar.date(from: bedTimeDateComponents) ?? Date.now
                noAlarmData = false
            }
            hhmmFormatter.dateFormat = "HH:mm"
        
        }
        .onDisappear {
            let newAlarm = Alarm(time: alarmTime, timeRange: alarmWindow, workoutType: workoutType, sound: sound, bedTime: bedTime)
            if alarms.count == 0 {
                context.insert(newAlarm)
            }
            do {
                try context.save() // Save to persistent store
            } catch {
                print("Failed to save alarm: \(error)")
            }
        }
    }
}

