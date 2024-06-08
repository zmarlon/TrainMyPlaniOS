//
//  ContentView.swift
//  TrainMyPlan
//
//  Created by Marlon Klaus on 07.06.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var workoutStore: WorkoutStore
    
    var body: some View {
            TabView {
                EditView(workoutStore: workoutStore)
                    .tabItem {
                        Image(systemName: "square.and.pencil")
                        Text("Edit")
                    }
                
                GoView()
                    .tabItem {
                        Image(systemName: "play.tv")
                        Text("Go")
                    }
                
                SettingsView(workoutStore: workoutStore)
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }
            }
        }
}
