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
                .onAppear {
                    print("ONENTER")
                    Task {
                        do {
                            let loadedStore = try await WorkoutStore.load()
                            self.workoutStore.setWorkouts(store: loadedStore)
                        } catch {
                            print("Fehler beim Laden der Daten: \(error)")
                        }
                    }
                }
                .onDisappear {
                    print("ONEXIT")
                
                    Task {
                        do {
                            try await WorkoutStore.save(store: workoutStore)
                        }
                    }
                }
        }
    }
}
