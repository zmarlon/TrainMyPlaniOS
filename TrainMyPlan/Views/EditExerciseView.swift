//
//  EditExerciseView.swift
//  TrainMyPlan
//
//  Created by Marlon Klaus on 07.06.24.
//

import SwiftUI

struct EditExerciseView: View {
    @Binding var exercise: Exercise
    
    var body: some View {
        VStack {
            Text(exercise.name)
        }.navigationTitle(exercise.name)
    }
}
