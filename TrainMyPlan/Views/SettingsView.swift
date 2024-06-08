//
//  SettingsView.swift
//  TrainMyPlan
//
//  Created by Marlon Klaus on 08.06.24.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var workoutStore: WorkoutStore
    #if DEBUG
    @State private var showingPrintAlert = false
    @State private var showingLoadAlert = false
    @State private var showingSaveAlert = false
    @State private var message = ""
    #endif
    
    var body: some View {
        VStack {
            #if DEBUG
            Button("Print JSON") {
                let encoder = JSONEncoder()
                
                do {
                    let jsonData = try encoder.encode(workoutStore)
                    if let jsonString = String(data: jsonData, encoding: .utf8) {
                        message = jsonString
                    }
                } catch {
                    message = "Failed"
                }
                
                showingPrintAlert = true
            }
            .alert(message, isPresented: $showingPrintAlert) {
                Button("OK", role: .cancel) { }
            }
            
            Button("Load") {
                Task {
                    do {
                        let loadedStore = try await WorkoutStore.load()
                        self.workoutStore.setWorkouts(store: loadedStore)
                    } catch {
                        print("Fehler beim Laden der Daten: \(error)")
                    }
                }
            }
            
            Button("Save") {
                Task {
                    do {
                        try await WorkoutStore.save(store: workoutStore)
                        showingSaveAlert = true
                    }
                }
            }.alert("Saved", isPresented: $showingSaveAlert) {
                Button("OK", role: .cancel) { }
            }
            
            #endif
        }
        .padding()
    }
}
