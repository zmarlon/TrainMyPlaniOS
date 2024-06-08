//
//  TrainMyPlanApp.swift
//  TrainMyPlan
//
//  Created by Marlon Klaus on 07.06.24.
//

import SwiftUI
import UIKit

@main
struct TrainMyPlanApp: App {
    @StateObject private var workoutStore = WorkoutStore()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView(workoutStore: workoutStore)
                .onAppear {
                    appDelegate.workoutStore = workoutStore
                    Task {
                        do {
                            let loadedStore = try await WorkoutStore.load()
                            self.workoutStore.setWorkouts(store: loadedStore)
                        } catch {
                            print("Failed to load data \(error)")
                        }
                    }
                }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var workoutStore: WorkoutStore?
    
    func applicationWillTerminate(_ application: UIApplication) {
        if let store = workoutStore {
            do {
                try WorkoutStore.save(store: store)
            }  catch {
                print("Failed to save data \(error)")
            }
        }
    }
}
