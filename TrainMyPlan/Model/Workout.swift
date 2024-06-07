//
//  Workout.swift
//  TrainMyPlan
//
//  Created by Marlon Klaus on 07.06.24.
//

import SwiftUI

class Workout: ObservableObject, Identifiable {
    let id = UUID()
    
    @Published var name: String
    @Published var exercises: [Exercise]
    
    weak var parent: WorkoutStore?
    
    init(name: String, exercises: [Exercise], parent: WorkoutStore? = nil) {
        self.name = name
        self.exercises = exercises
        self.parent = parent
    }
    
    func addExercise() {
        let newExercise = Exercise(name: "New Exercise", repetitions: 8...12)
        exercises.append(newExercise)
        
        objectWillChange.send()
        parent?.objectWillChange.send()
    }
}

class WorkoutStore: ObservableObject {
    @Published var workouts: [Workout]
    
    init() {
        self.workouts = []
        
        addWorkout(workout: Workout(name: "Brust", exercises: [
            Exercise(name: "Bankdrücken", repetitions: 8...12),
            Exercise(name: "Butterfly", repetitions: 8...12),
            Exercise(name: "Bankdrücken Maschine", repetitions: 8...12)
        ]))
        
        addWorkout(workout: Workout(name: "Rücken", exercises: [
            Exercise(name: "Rudern", repetitions: 8...12),
            Exercise(name: "Rudern Kurzhantel", repetitions: 6...8)
        ]))
    }

    
    func addWorkout(workout: Workout) {
        workout.parent = self
        workouts.append(workout)
        objectWillChange.send()
    }
    
    func removeWorkout(at indexSet: IndexSet) {
        workouts.remove(atOffsets: indexSet)
        objectWillChange.send()
    }
}
