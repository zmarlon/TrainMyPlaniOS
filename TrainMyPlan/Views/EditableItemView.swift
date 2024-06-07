//
//  EditableItemView.swift
//  TrainMyPlan
//
//  Created by Marlon Klaus on 07.06.24.
//

import SwiftUI

struct EditableItemView: View {
    @Binding var workout: Workout
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(workout.name)
        }
        .contentShape(Rectangle())
    }
}
