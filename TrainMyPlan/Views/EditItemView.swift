//
//  EditItemView.swift
//  TrainMyPlan
//
//  Created by Marlon Klaus on 07.06.24.
//

import SwiftUI

struct EditItemView: View {
    @Binding var workout: Workout
    
    init(workout: Binding<Workout>) {
        _workout = workout
    }
        
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("", text: $workout.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
            CenteredHeadline(content: "Exercises")
            
            List {
                ForEach($workout.exercises) { exercise in
                    NavigationLink(destination: EditExerciseView(exercise: exercise)) {
                        EditableExerciseView(exercise: exercise)
                    }
                }.onDelete { indexSet in
                    workout.exercises.remove(atOffsets: indexSet)
                }
            }
            
            Spacer()
        }
        .navigationTitle("Edit workout")
        .navigationBarItems(trailing: addButton)
    }
    
    var addButton: some View {
            Button(action: {
                workout.addExercise(newExercise: Exercise(name: "New Exercise", repetitions: 8...12, sets: 2, comment: ""))
            }) {
                Image(systemName: "plus")
            }
        }
}
