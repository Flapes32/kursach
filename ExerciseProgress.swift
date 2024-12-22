import Foundation

struct ExerciseProgress: Identifiable, Codable {
    let id = UUID()
    let exerciseId: UUID
    let date: Date
    let duration: TimeInterval
    let repetitions: Int?
    let sets: Int?
    let difficulty: Int // User-rated difficulty from 1-5
    let notes: String?
    let caloriesBurned: Int?
    
    // For interval training
    let completedIntervals: Int?
    
    static func create(
        exerciseId: UUID,
        duration: TimeInterval,
        repetitions: Int? = nil,
        sets: Int? = nil,
        difficulty: Int,
        notes: String? = nil,
        caloriesBurned: Int? = nil,
        completedIntervals: Int? = nil
    ) -> ExerciseProgress {
        ExerciseProgress(
            exerciseId: exerciseId,
            date: Date(),
            duration: duration,
            repetitions: repetitions,
            sets: sets,
            difficulty: min(max(difficulty, 1), 5),
            notes: notes,
            caloriesBurned: caloriesBurned,
            completedIntervals: completedIntervals
        )
    }
}

// Manager class to handle exercise progress persistence and retrieval
class ExerciseProgressManager: ObservableObject {
    @Published private(set) var progressHistory: [ExerciseProgress] = []
    
    private let userDefaults = UserDefaults.standard
    private let progressKey = "exerciseProgress"
    
    init() {
        loadProgress()
    }
    
    func addProgress(_ progress: ExerciseProgress) {
        progressHistory.append(progress)
        saveProgress()
    }
    
    func getProgress(for exerciseId: UUID) -> [ExerciseProgress] {
        progressHistory.filter { $0.exerciseId == exerciseId }
    }
    
    private func loadProgress() {
        guard let data = userDefaults.data(forKey: progressKey),
              let progress = try? JSONDecoder().decode([ExerciseProgress].self, from: data) else {
            return
        }
        progressHistory = progress
    }
    
    private func saveProgress() {
        guard let data = try? JSONEncoder().encode(progressHistory) else { return }
        userDefaults.set(data, forKey: progressKey)
    }
}
