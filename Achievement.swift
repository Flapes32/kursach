import Foundation

enum AchievementCategory: String, CaseIterable {
    case beginner = "Новичок"
    case intermediate = "Продвинутый"
    case master = "Мастер"
    case expert = "Эксперт"
}

enum AchievementType: String {
    case workoutCount = "Количество тренировок"
    case roundTime = "Время раундов"
    case intensity = "Интенсивность"
    case streak = "Серия тренировок"
}

struct Achievement: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String
    let category: AchievementCategory
    let type: AchievementType
    let requiredValue: Int
    var progress: Int
    let iconName: String
    
    var progressPercentage: Double {
        min(Double(progress) / Double(requiredValue), 1.0)
    }
    
    var isCompleted: Bool {
        progress >= requiredValue
    }
}

class AchievementManager: ObservableObject {
    @Published var achievements: [Achievement] = []
    
    init() {
        setupDefaultAchievements()
    }
    
    private func setupDefaultAchievements() {
        achievements = [
            // Тренировки
            Achievement(title: "Первые шаги", description: "Выполните первую тренировку", category: .beginner, type: .workoutCount, requiredValue: 1, progress: 0, iconName: "figure.boxing"),
            Achievement(title: "На пути к успеху", description: "Выполните 10 тренировок", category: .beginner, type: .workoutCount, requiredValue: 10, progress: 0, iconName: "figure.boxing"),
            Achievement(title: "Постоянство", description: "Выполните 50 тренировок", category: .intermediate, type: .workoutCount, requiredValue: 50, progress: 0, iconName: "figure.boxing"),
            
            // Серии
            Achievement(title: "Упорство", description: "Тренируйтесь 3 дня подряд", category: .beginner, type: .streak, requiredValue: 3, progress: 0, iconName: "flame"),
            Achievement(title: "Железная воля", description: "Тренируйтесь 7 дней подряд", category: .intermediate, type: .streak, requiredValue: 7, progress: 0, iconName: "flame.fill"),
            
            // Интенсивность
            Achievement(title: "Скорость", description: "Достигните высокой интенсивности в тренировке", category: .intermediate, type: .intensity, requiredValue: 1, progress: 0, iconName: "speedometer"),
            Achievement(title: "Мастер скорости", description: "Достигните высокой интенсивности в 10 тренировках", category: .master, type: .intensity, requiredValue: 10, progress: 0, iconName: "speedometer.fill")
        ]
    }
    
    func updateProgress(type: AchievementType, value: Int) {
        for index in achievements.indices {
            if achievements[index].type == type {
                achievements[index].progress += value
            }
        }
    }
}
