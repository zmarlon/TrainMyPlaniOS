//
//  EditView.swift
//  TrainMyPlan
//
//  Created by Marlon Klaus on 07.06.24.
//

import SwiftUI

struct EditView: View {
    @StateObject private var workoutStore = WorkoutStore()
    
    var body: some View {
        NavigationView {
            List {
                ForEach($workoutStore.workouts) { workout in
                    NavigationLink(destination: EditItemView(workout: workout)) {
                        EditableItemView(workout: workout)
                    }
                }
                .onDelete { indexSet in
                    workoutStore.removeWorkout(at: indexSet)
                }
            }
            .navigationTitle("My workouts")
            .navigationBarItems(trailing: addButton)
        }
    }
    
    var addButton: some View {
            Button(action: {
                let newWorkout = Workout(name: "New workout", exercises: [])
                workoutStore.addWorkout(workout: newWorkout)
            }) {
                Image(systemName: "plus")
            }
        }
}
