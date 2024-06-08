//
//  Workout.swift
//  TrainMyPlan
//
//  Created by Marlon Klaus on 07.06.24.
//

import SwiftUI

class Workout: ObservableObject, Identifiable, Codable {
    var id = UUID()
    
    @Published var name: String
    @Published var exercises: [Exercise]
    
    weak var parent: WorkoutStore?
    
    init(name: String, exercises: [Exercise], parent: WorkoutStore? = nil) {
        self.name = name
        self.exercises = []
        self.parent = parent
        
        for exercise in exercises {
            addExercise(newExercise: exercise)
        }
    }
    
    func addExercise(newExercise: Exercise) {
        newExercise.parent = parent
        exercises.append(newExercise)
        
        objectWillChange.send()
        parent?.objectWillChange.send()
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case exercises
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(exercises, forKey: .exercises)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        exercises = try container.decode([Exercise].self, forKey: .exercises)
            
        for exercise in exercises {
            exercise.parent = parent
        }
    }
}

class WorkoutStore: ObservableObject, Codable {
    @Published var workouts: [Workout]
    
    init() {
        self.workouts = []
        
        addWorkout(workout: Workout(name: "Brust", exercises: [
            Exercise(name: "Bankdrücken", repetitions: 8...12, sets: 2, comment: ""),
            Exercise(name: "Butterfly", repetitions: 8...12, sets: 2, comment: ""),
            Exercise(name: "Bankdrücken Maschine", repetitions: 8...12, sets: 2, comment: "")
        ]))
        
        addWorkout(workout: Workout(name: "Rücken", exercises: [
            Exercise(name: "Rudern", repetitions: 8...12, sets: 2, comment: ""),
            Exercise(name: "Rudern Kurzhantel", repetitions: 6...8, sets: 2, comment: "")
        ]))
    }

    
    func addWorkout(workout: Workout) {
        workout.parent = self
        workouts.append(workout)
        objectWillChange.send()
        
        //Set exercise parents
        for exercise in workout.exercises {
            exercise.parent = self
        }
    }
    
    func removeWorkout(at indexSet: IndexSet) {
        workouts.remove(atOffsets: indexSet)
        objectWillChange.send()
    }
    
    enum CodingKeys: String, CodingKey {
        case workouts
    }
        
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(workouts, forKey: .workouts)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        workouts = try container.decode([Workout].self, forKey: .workouts)
            
        for workout in workouts {
            workout.parent = self
        }
    }
    
    //Save behaviour
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                        in: .userDomainMask,
                                        appropriateFor: nil,
                                        create: false)
            .appendingPathComponent("trainmyplan.data")
    }


    static func load() async throws -> WorkoutStore {
        let task = Task<WorkoutStore, Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return WorkoutStore()
            }
            let workoutStore = try JSONDecoder().decode(WorkoutStore.self, from: data)
            return workoutStore
        }
        let workoutStore = try await task.value
        return workoutStore
    }
    
    static func save(store: WorkoutStore) throws {
        let data = try JSONEncoder().encode(store)
        let outfile = try Self.fileURL()
        try data.write(to: outfile)
    }
    
    func setWorkouts(store: WorkoutStore) {
        self.workouts = store.workouts
        
        for workout in self.workouts {
            workout.parent = self
            
            for exercise in workout.exercises {
                exercise.parent = self
            }
        }
        
        objectWillChange.send()
    }
}
