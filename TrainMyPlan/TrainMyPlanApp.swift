//
//  TrainMyPlanApp.swift
//  TrainMyPlan
//
//  Created by Marlon Klaus on 07.06.24.
//

import SwiftUI

@main
struct TrainMyPlanApp: App {
    @StateObject private var workoutStore = WorkoutStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView(workoutStore: workoutStore)
        }
    }
}
