//
//  EditExerciseView.swift
//  TrainMyPlan
//
//  Created by Marlon Klaus on 07.06.24.
//

import SwiftUI

struct EditExerciseView: View {
    @Binding var exercise: Exercise
    @State var name: String = ""
    @State var min: String = ""
    @State var max: String = ""
    
    var body: some View {
        VStack {
            TextField("Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
            CenteredHeadline(content: "Repetitions")
            
            NumberTextInputField(preview: "Min", input: $min)
            NumberTextInputField(preview: "Max", input: $max)
        }.navigationTitle("Edit exercise")
        .onAppear {
            name = exercise.name
            min = String(exercise.repetitions.lowerBound)
            max = String(exercise.repetitions.upperBound)
        }
        .onDisappear {
            exercise.setName(name: name)
            exercise.setRepetitions(min: min, max: max)
        }
    }
}
