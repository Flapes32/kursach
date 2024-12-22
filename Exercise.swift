import Foundation

enum Difficulty: String, CaseIterable {
    case beginner = "Начинающий"
    case intermediate = "Средний"
    case advanced = "Продвинутый"
    case professional = "Профессионал"
}

enum ExerciseCategory: String, CaseIterable {
    case cardio = "Кардио"
    case strength = "Силовые"
    case flexibility = "Гибкость"
    case functional = "Функциональные"
    case interval = "Интервальные"
    case technique = "Техника"
    case warmup = "Разминка"
    case combinations = "Комбинации"
}

struct Exercise: Identifiable, Hashable, Codable {
    let id = UUID()
    let name: String
    let description: String
    let instructions: String
    let category: ExerciseCategory
    let difficulty: Difficulty
    let videoURL: String
    let tips: [String]
    let commonMistakes: [String]
    let equipment: [String]
    let duration: Int // Длительность выполнения в секундах
    let repetitions: Int // Количество повторений
}

struct SampleExercise {
    let name: String
    let description: String
    let instructions: String
    let category: ExerciseCategory
    let duration: Int // in seconds
    let repetitions: Int?
    let videoLink: String?
}

// Sample exercises
let sampleExercises: [SampleExercise] = [
    SampleExercise(name: "Running", description: "A great cardio workout to improve endurance.", instructions: "Run at a steady pace for 30 minutes.", category: .cardio, duration: 1800, repetitions: nil, videoLink: "https://example.com/running_video"),
    SampleExercise(name: "Push Up", description: "A basic strength exercise for upper body.", instructions: "Lower your body until your chest nearly touches the floor, then push back up.", category: .strength, duration: nil, repetitions: 15, videoLink: "https://example.com/pushup_video"),
    SampleExercise(name: "Yoga Stretch", description: "Improves flexibility and relaxation.", instructions: "Hold each stretch for 30 seconds.", category: .flexibility, duration: 600, repetitions: nil, videoLink: "https://example.com/yoga_video")
]

// База данных упражнений
struct ExerciseDatabase {
    static let exercises: [Exercise] = [
        // Разминка
        Exercise(
            name: "Техника",
            description: "Основные техники бокса",
            instructions: "Примите боевую стойку",
            category: .warmup,
            difficulty: .beginner,
            videoURL: "https://www.youtube.com/watch?v=FJmRQ5iTXKE",
            tips: ["Начните с базовых прыжков"],
            commonMistakes: ["Слишком высокие прыжки"],
            equipment: ["Боксерские перчатки", "Бинты"],
            duration: 10,
            repetitions: 10
        ),
        // Техника
        Exercise(
            name: "Техника",
            description: "Основные техники бокса",
            instructions: "Примите боевую стойку",
            category: .technique,
            difficulty: .beginner,
            videoURL: "https://www.youtube.com/watch?v=1D9v6KtBQrk",
            tips: ["Держите вторую руку у подбородка", "Разворачивайте кулак в конце удара"],
            commonMistakes: ["Опущенная вторая рука"],
            equipment: ["Боксерские перчатки", "Бинты"],
            duration: 10,
            repetitions: 10
        ),
        Exercise(
            name: "Кросс",
            description: "Боксерская техника кросса",
            instructions: "Из боевой стойки",
            category: .technique,
            difficulty: .intermediate,
            videoURL: "https://www.youtube.com/watch?v=2Xo3NJ7LCCw",
            tips: ["Используйте вращение бедер", "Держите защиту"],
            commonMistakes: ["Нет вращения корпуса"],
            equipment: ["Боксерские перчатки", "Бинты"],
            duration: 15,
            repetitions: 8
        ),
        // Комбинации
        Exercise(
            name: "Джеб",
            description: "Боксерская техника джеба",
            instructions: "Джеб передней рукой",
            category: .combinations,
            difficulty: .intermediate,
            videoURL: "https://www.youtube.com/watch?v=7v0_uipNGao",
            tips: ["Начинайте медленно", "Следите за точностью"],
            commonMistakes: ["Остановка между ударами"],
            equipment: ["Боксерские перчатки", "Бинты", "Груша"],
            duration: 20,
            repetitions: 5
        ),
        Exercise(
            name: "Бой с тенью",
            description: "Постоянное движение",
            instructions: "Постоянное движение",
            category: .technique,
            difficulty: .advanced,
            videoURL: "https://www.youtube.com/watch?v=kqB19LuJ5jE",
            tips: ["Представляйте реального противника", "Работайте в разных темпах"],
            commonMistakes: ["Отсутствие защитных действий"],
            equipment: ["Боксерские перчатки (опционально)"],
            duration: 45,
            repetitions: 2
        )
    ]
}
