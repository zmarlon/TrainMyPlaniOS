//
//  Exercise.swift
//  TrainMyPlan
//
//  Created by Marlon Klaus on 07.06.24.
//

import SwiftUI

class Exercise: ObservableObject, Identifiable {
    let id = UUID()
    var name: String
    var repetitions: ClosedRange<Int>
    
    weak var parent: WorkoutStore?
    
    init(name: String, repetitions: ClosedRange<Int>) {
        self.name = name
        self.repetitions = repetitions
    }
    
    func setName(name: String) {
        self.name = name
        parent?.objectWillChange.send()
    }
    
    func setRepetitions(min: String, max: String) {
        self.repetitions = Int(min)!...Int(max)!
        parent?.objectWillChange.send()
    }
}
