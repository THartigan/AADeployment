//
//  ContentView.swift
//  AADeployment Watch App
//
//  Created by Thomas Hartigan on 25/09/2024.
//

import SwiftUI
import CoreMotion
import HealthKitUI
import CoreML

struct SitupChallengeView: View {
    @StateObject var modelProcessing = ModelProcessing()
    @State var frame = 0
    @StateObject var motion = Motion()
    @StateObject var health = Health()
    @State private var trigger = false
    @State private var authenticated = false
    @State var healthQuery: HKAnchoredObjectQuery?
    @State var times: [Date] = []
    @State var heartRates: [Int] = []
    @State var motionDatas: [MotionData] = []
    @State var currentUUID: UUID = UUID()
    
    var body: some View {
//        VStack{
//            if let motionData = motion.currentMotionData {
//                Text("P: \(String(format: "%.2f", motionData.pitch)), R: \(String(format: "%.2f", motionData.roll)), Y: \(String(format: "%.2f", motionData.yaw))")
//                Text("A: (\(String(format: "%.2f", motionData.acceleration.x)), \(String(format: "%.2f", motionData.acceleration.y)), \(String(format: "%.2f", motionData.acceleration.z)))")
//                if self.authenticated {
//                    Text("HR: \(health.lastHeartRate)")
//                }
//            }
//            Text("\(String(modelProcessing.numOutputs)) 0: \(String(format: "%.2f", modelProcessing.outputs[0])) 1: \(String(format: "%.2f", modelProcessing.outputs[1]))")
//            Text("Counted: \(String(modelProcessing.totalSitups))")
//            
//            
//        }
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
                
                Text("\(Int(modelProcessing.totalSitups)) Counted")
                Spacer()
                Button {
                    trigger.toggle()
                    trigger ? start() : stop()
                } label: {
                    Text(trigger ? "Stop" : "Start")
                }
//                if let grav = motion.currentMotionData?.gravity.abs {
//                    Text(String(grav))
//                }
                

                // Additional UI elements
            }
        }
        .healthDataAccessRequest(store: health.healthStore, readTypes: health.allTypes, trigger: trigger, completion: { result in
            switch result {
                
            case .success(_):
                self.authenticated = true
            case .failure(_):
                fatalError("Error whilst getting healthkit authentication")
            }
                
        })
        .onChange(of: motion.currentMotionData, { oldValue, newValue in
//            print(self.authenticated)
            if let motionData = motion.currentMotionData{
                if self.authenticated {
                    self.times.append(Date.now)
                    self.heartRates.append(health.lastHeartRate)
                    self.motionDatas.append(motionData)
//                    print(self.frame)
                    if self.frame >= 200 && self.frame % 200 == 0 {
//                        print("running model")
                        self.modelProcessing.process(times: self.times.suffix(200), motionDatas: self.motionDatas.suffix(200))
                    }
                    
                    self.frame += 1
                }
            }
        })
    }

    func start() {
        currentUUID = UUID()
//        trigger.toggle()
        self.healthQuery = health.startHeartRateQuery(quantityTypeIdentifier: .heartRate)
        self.motion.startDeviceMotion()
        print("Started")
    }

    func stop() {
        print("Stopping")
//        trigger.toggle()
        self.motion.stopDeviceMotion()
        if let query = self.healthQuery {
            self.health.stopHeartRateQuery(query: query)
        }
        var workoutDatas: [WorkoutData] = []
        for (i, time) in times.enumerated() {
            workoutDatas.append(WorkoutData(time: time.timeIntervalSince1970, heartRate: self.heartRates[i], motion: self.motionDatas[i], workoutType: "situp"))
        }
//            phoneConnector.sendDataToPhone(finalDatas)
    }

}

//#Preview {
//    WorkoutDetail(workout: "Run")
//}

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    var body: some View {
//        ZStack {
//            Color.blue
//                .ignoresSafeArea()
//            Image(systemName: "figure.core.training")
//                .resizable()
//                .scaledToFit()
//                .opacity(0.2)
//            //                .foregroundColor(Color.gray)
//            //
//            VStack {
//                
//                Text("Situp Counter")
//                    .font(.headline)
//                Spacer()
//                Text(" \(Int(2)) Completed")
//                Button {
//                    self.counting.toggle()
//                    if self.counting {
//                        start()
//                    } else {
//                        stop()
//                    }
//                } label: {
//                    Text(!counting ? "Start" : "Stop")
//                        .font(.title)
//                        .fontWeight(.bold)
//                        .padding()
//                        .cornerRadius(10)
//                }
//                
//            }
//            .padding()
//            
//        }
//        .healthDataAccessRequest(store: health.healthStore, readTypes: health.allTypes, trigger: counting, completion: { result in
//            switch result {
//                
//            case .success(_):
//                self.authenticated = true
//            case .failure(_):
//                fatalError("Error whilst getting healthkit authentication")
//            }
//                
//        })
//        
//        
//    }
//    
//    func start() {
//        
//    }
//    
//    func stop() {
//        
//    }
//}

