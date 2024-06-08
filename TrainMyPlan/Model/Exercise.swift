//
//  Exercise.swift
//  TrainMyPlan
//
//  Created by Marlon Klaus on 07.06.24.
//

import SwiftUI

class Exercise: ObservableObject, Identifiable, Codable {
    var id = UUID()
    var name: String
    var repetitions: ClosedRange<Int>
    
    weak var parent: WorkoutStore?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case repetitions
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode([repetitions.lowerBound, repetitions.upperBound], forKey: .repetitions)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let repsArray = try container.decode([Int].self, forKey: .repetitions)
        repetitions = repsArray[0]...repsArray[1]
    }
    
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
