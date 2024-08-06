//
//  ExerciseResult.swift
//  TrainMyPlan
//
//  Created by Marlon Klaus on 06.08.24.
//

import SwiftUI

class ExerciseResult: Identifiable, Codable {
    var id = UUID()
    
    var setResult: [UInt32] = []
    var comment: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case setResult
        case comment
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(setResult, forKey: .setResult)
        try container.encode(comment, forKey: .comment)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        setResult = try container.decode([UInt32].self, forKey: .setResult)
        comment = try container.decode(String.self, forKey: .comment)
    }
    
    init() {}
}
