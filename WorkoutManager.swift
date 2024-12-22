import Foundation
import Combine

class WorkoutManager {
    static let shared = WorkoutManager()
    private var workoutHistory: [WorkoutHistory] = []
    @Published var achievementManager = AchievementManager()
    @Published var userLevel = UserLevel()
    
    private init() {}
    
    func addWorkout(exerciseName: String, repetitions: Int) {
        let newWorkout = WorkoutHistory(exerciseName: exerciseName, date: Date(), repetitions: repetitions)
        workoutHistory.append(newWorkout)
        
        // Обновляем достижения
        achievementManager.updateProgress(type: .workoutCount, value: 1)
        
        // Проверяем серию тренировок
        checkWorkoutStreak()
        
        // Добавляем опыт за тренировку
        let xpGained = calculateXP(repetitions: repetitions)
        userLevel.addXP(xpGained)
    }
    
    private func calculateXP(repetitions: Int) -> Int {
        // Базовый опыт за тренировку
        var xp = 50
        
        // Дополнительный опыт за количество повторений
        xp += repetitions * 2
        
        // Бонус за серию тренировок
        let streak = calculateCurrentStreak()
        if streak > 1 {
            xp += streak * 10
        }
        
        return xp
    }
    
    private func calculateCurrentStreak() -> Int {
        let calendar = Calendar.current
        var currentStreak = 1
        var previousDate = Date()
        
        for workout in workoutHistory.sorted(by: { $0.date > $1.date }) {
            if calendar.isDate(previousDate, inSameDayAs: workout.date) {
                continue
            }
            
            let daysBetween = calendar.dateComponents([.day], from: workout.date, to: previousDate).day ?? 0
            if daysBetween == 1 {
                currentStreak += 1
                previousDate = workout.date
            } else {
                break
            }
        }
        
        return currentStreak
    }
    
    private func checkWorkoutStreak() {
        let streak = calculateCurrentStreak()
        achievementManager.updateProgress(type: .streak, value: streak)
    }
    
    func getWorkoutHistory() -> [WorkoutHistory] {
        return workoutHistory
    }
    
    func removeWorkout(at index: Int) {
        guard index >= 0 && index < workoutHistory.count else { return }
        workoutHistory.remove(at: index)
    }
    
    func getWorkouts(for date: Date) -> [WorkoutHistory] {
        let calendar = Calendar.current
        return workoutHistory.filter { calendar.isDate($0.date, inSameDayAs: date) }
    }
}
