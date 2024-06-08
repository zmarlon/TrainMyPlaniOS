//
//  SettingsView.swift
//  TrainMyPlan
//
//  Created by Marlon Klaus on 08.06.24.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var workoutStore: WorkoutStore
    
    var body: some View {
        VStack {

            #if DEBUG
            Button(action: {
                let encoder = JSONEncoder()
                
                do {
                    let jsonData = try encoder.encode(workoutStore)
                    if let jsonString = String(data: jsonData, encoding: .utf8) {
                        print(jsonString)
                    }
                } catch {
                    print("Failed to create json: \(error)")
                }
            }) {
                Text("Print JSON")
            }
            #endif
        }
        .padding()
    }
}
