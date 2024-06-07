//
//  Exercise.swift
//  TrainMyPlan
//
//  Created by Marlon Klaus on 07.06.24.
//

import SwiftUI

class Exercise: Identifiable {
    let id = UUID()
    var name: String
    var repetitions: ClosedRange<Int>
    
    init(name: String, repetitions: ClosedRange<Int>) {
        self.name = name
        self.repetitions = repetitions
    }
}
