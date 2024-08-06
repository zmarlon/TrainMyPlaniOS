//
//  GoWorkoutView.swift
//  TrainMyPlan
//
//  Created by Marlon Klaus on 06.08.24.
//

import SwiftUI

struct GoWorkoutView: View {
    @Binding var workout: Workout
    
    var body: some View {
        VStack {
            Text("This is a test")
        }
    }
}

struct GoWorkoutExerciseView: View {
    var exercise: Exercise
    var setIndex: Int
    
    @State var repetitions: String = ""
    
    var body: some View {
        Text(exercise.name)
        
        Text("Set \(setIndex + 1) of \(exercise.sets)")
        NumberTextInputField(preview: "Repetitions", input: $repetitions )
        
        Button(action: {
            
        }) {
            let content = if setIndex == exercise.sets - 1 {
                "Next exercise"
            } else {
                "Next set"
            }
            
            Text(content)
        }
    }
}
