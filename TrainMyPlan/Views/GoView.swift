//
//  GoView.swift
//  TrainMyPlan
//
//  Created by Marlon Klaus on 07.06.24.
//

import SwiftUI

struct GoView: View {
    @StateObject var workoutStore: WorkoutStore
    @StateObject var workoutResultStore: WorkoutResultStore
    
    var body: some View {
        NavigationView {
            List {
                ForEach($workoutStore.workouts) { workout in
                    NavigationLink(destination: GoWorkoutView(workout: workout)) {
                        EditableItemView(workout: workout)
                    }
                }
                .onDelete { indexSet in
                    workoutStore.removeWorkout(at: indexSet)
                }
            }
            .navigationTitle("Go and work out!")
        }
    }
}




