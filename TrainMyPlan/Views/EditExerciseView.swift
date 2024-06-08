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
    @State var sets: String = ""
    @State var comment: String = ""
    
    var body: some View {
        VStack {
            TextField("Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
            CenteredHeadline(content: "Repetitions")
            
            NumberTextInputField(preview: "Min", input: $min)
            NumberTextInputField(preview: "Max", input: $max)
            
            CenteredHeadline(content: "Sets")
            
            NumberTextInputField(preview: "Sets", input: $sets)
            
            CenteredHeadline(content: "Comment")
            
            TextField("Comment", text: $comment)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
        }.navigationTitle("Edit exercise")
        .onAppear {
            name = exercise.name
            min = String(exercise.repetitions.lowerBound)
            max = String(exercise.repetitions.upperBound)
            sets = String(exercise.sets)
            comment = exercise.comment
        }
        .onDisappear {
            exercise.setName(name: name)
            exercise.setRepetitions(min: min, max: max)
            exercise.setSets(sets: Int(sets)!)
            exercise.setComment(comment: comment)
        }
    }
}
