//
//  EditableExerciseView.swift
//  TrainMyPlan
//
//  Created by Marlon Klaus on 07.06.24.
//

import SwiftUI

struct EditableExerciseView: View {
    @Binding var exercise: Exercise
    
    var body: some View {
        VStack {
            Text("\(exercise.name) \(exercise.sets)x \(exercise.repetitions.lowerBound)-\(exercise.repetitions.upperBound)")
        }
    }
}
