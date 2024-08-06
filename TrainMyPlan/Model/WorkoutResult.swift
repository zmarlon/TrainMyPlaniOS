//
//  WorkoutResult.swift
//  TrainMyPlan
//
//  Created by Marlon Klaus on 06.08.24.
//

import SwiftUI

class WorkoutResult: Identifiable, Codable, ObservableObject {
    var id = UUID()
    
    var exerciseResults: [ExerciseResult]
    var exerciseIndex: UInt32 = 0
    var setIndex: UInt32 = 0
    
    enum CodingKeys: String, CodingKey {
        case exerciseResults
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(exerciseResults, forKey: .exerciseResults)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        exerciseResults = try container.decode([ExerciseResult].self, forKey: .exerciseResults)
    }
    
    init(numExercises: UInt32) {
        exerciseResults = (0..<numExercises).map { _ in
            ExerciseResult()
        }
    }
}

class WorkoutResultStore: Codable, ObservableObject {
    var results: [UUID: [WorkoutResult]] = [:]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(results, forKey: .results)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        results = try container.decode([UUID: [WorkoutResult]].self, forKey: .results)
    }
    
    init() {}
    
    //Save behaviour
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                        in: .userDomainMask,
                                        appropriateFor: nil,
                                        create: false)
            .appendingPathComponent("trainmyplan.data.results")
    }


    static func load() async throws -> WorkoutResultStore {
        let task = Task<WorkoutResultStore, Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return WorkoutResultStore()
            }
            let workoutStore = try JSONDecoder().decode(WorkoutResultStore.self, from: data)
            return workoutStore
        }
        let workoutStore = try await task.value
        return workoutStore
    }
    
    static func save(store: WorkoutResultStore) throws {
        let data = try JSONEncoder().encode(store)
        let outfile = try Self.fileURL()
        try data.write(to: outfile)
    }
    
    func setResults(store: WorkoutResultStore) {
        self.results = store.results
    
        objectWillChange.send()
    }
}
