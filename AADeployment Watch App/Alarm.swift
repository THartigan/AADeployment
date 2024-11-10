//
//  Alarm.swift
//  AADeployment Watch App
//
//  Created by Thomas Hartigan on 25/09/2024.
//

import Foundation
import SwiftData

@Model
class Alarm: Identifiable {
    var id: UUID
    var time: Date
    var timeRange: Int
    var workoutType: String
    var sound: String
    var bedTime: Date
    
    init(id: UUID = UUID(), time: Date, timeRange: Int, workoutType: String, sound: String, bedTime: Date) {
        self.id = id
        self.time = time
        self.timeRange = timeRange
        self.workoutType = workoutType
        self.sound = sound
        self.bedTime = bedTime
    }
}


