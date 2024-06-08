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
    var sets: Int
    var comment: String
    
    weak var parent: WorkoutStore?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case repetitions
        case sets
        case comment
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode([repetitions.lowerBound, repetitions.upperBound], forKey: .repetitions)
        try container.encode(sets, forKey: .sets)
        try container.encode(comment, forKey: .comment)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let repsArray = try container.decode([Int].self, forKey: .repetitions)
        repetitions = repsArray[0]...repsArray[1]
        sets = try container.decode(Int.self, forKey: .sets)
        comment = try container.decode(String.self, forKey: .comment)
    }
    
    init(name: String, repetitions: ClosedRange<Int>, sets: Int, comment: String) {
        self.name = name
        self.repetitions = repetitions
        self.sets = sets
        self.comment = comment
    }
    
    func setName(name: String) {
        self.name = name
        parent?.objectWillChange.send()
    }
    
    func setRepetitions(min: String, max: String) {
        self.repetitions = Int(min)!...Int(max)!
        parent?.objectWillChange.send()
    }
    
    func setSets(sets: Int) {
        self.sets = sets
        parent?.objectWillChange.send()
    }
    
    func setComment(comment: String) {
        self.comment = comment
        parent?.objectWillChange.send()
    }
}
