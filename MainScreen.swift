import SwiftUI
import Charts

// MARK: - Main Screen
struct MainScreen: View {
    @State private var selectedTab = 0
    @State private var showFAQ = false
    @State private var showQuestionForm = false
    @State private var questionText = ""
    @State private var roundDuration: Int = 60 // Длительность раунда в секундах
    @State private var restDuration: Int = 30 // Длительность отдыха в секундах
    @State private var numberOfRounds: Int = 3 // Количество раундов
    @State private var isTimerRunning: Bool = false // Статус таймера
    @State private var currentRound: Int = 0 // Текущий раунд
    @State private var timer: Timer? // Таймер
    @State private var remainingTime: Int = 0 // Оставшееся время
    @State private var showTimerView: Bool = false // Показать экран таймера
    
    // Состояния для нового экрана тренировок
    @State private var searchText = ""
    @State private var selectedDifficulty: Difficulty = .beginner
    @State private var selectedCategory: ExerciseCategory?
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Главная")
                }
                .tag(0)
            
            SocialView()
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Чат")
                }
                .tag(1)
            
            RecommendationsView(
                showFAQ: $showFAQ,
                showQuestionForm: $showQuestionForm,
                questionText: $questionText
            )
                .tabItem {
                    Image(systemName: "lightbulb.fill")
                    Text("Советы")
                }
                .tag(2)
            
            TimerSettingsView(
                roundDuration: $roundDuration,
                restDuration: $restDuration,
                numberOfRounds: $numberOfRounds,
                isTimerRunning: $isTimerRunning,
                currentRound: $currentRound,
                timer: $timer,
                remainingTime: $remainingTime,
                showTimerView: $showTimerView
            )
                .tabItem {
                    Image(systemName: "timer")
                    Text("Таймер")
                }
                .tag(3)
            
            ExerciseTrainingView(
                searchText: $searchText,
                selectedDifficulty: $selectedDifficulty,
                selectedCategory: $selectedCategory,
                showTimerView: $showTimerView
            )
                .tabItem {
                    Image(systemName: "figure.run")
                    Text("Тренировки")
                }
                .tag(4)
            
            AchievementsView()
                .tabItem {
                    Image(systemName: "trophy.fill")
                    Text("Достижения")
                }
                .tag(5)
            
            StatisticsView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Статистика")
                }
                .tag(6)
            
            HealthView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Здоровье")
                }
                .tag(7)
        }
        .accentColor(.yellow)
        .preferredColorScheme(.dark)
        .sheet(isPresented: $showFAQ) {
            FAQView()
        }
        .sheet(isPresented: $showQuestionForm) {
            QuestionFormView(questionText: $questionText)
        }
        .sheet(isPresented: $showTimerView) {
            TimerView(
                roundDuration: $roundDuration,
                restDuration: $restDuration,
                numberOfRounds: $numberOfRounds,
                isTimerRunning: $isTimerRunning,
                currentRound: $currentRound,
                timer: $timer,
                remainingTime: $remainingTime
            )
        }
    }
}

// MARK: - Models for Training
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
}

struct Exercise: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let description: String
    let category: ExerciseCategory
    let difficulty: Difficulty
    let duration: Int // в секундах
    let repetitions: Int? // опциональное количество повторений
}

// MARK: - Exercise Training View
struct ExerciseTrainingView: View {
    @Binding var searchText: String
    @Binding var selectedDifficulty: Difficulty
    @Binding var selectedCategory: ExerciseCategory?
    @Binding var showTimerView: Bool
    
    let exercises: [Exercise] = [
        Exercise(name: "Бег", description: "Кардио тренировка для выносливости", category: .cardio, difficulty: .beginner, duration: 600, repetitions: nil),
        Exercise(name: "Отжимания", description: "Базовое упражнение для верхней части тела", category: .strength, difficulty: .intermediate, duration: 0, repetitions: 15),
        Exercise(name: "Растяжка", description: "Улучшает гибкость", category: .flexibility, difficulty: .beginner, duration: 300, repetitions: nil),
        Exercise(name: "Берпи", description: "Комплексное функциональное упражнение", category: .functional, difficulty: .advanced, duration: 0, repetitions: 20)
    ]
    
    var filteredExercises: [Exercise] {
        exercises.filter { exercise in
            let matchesDifficulty = exercise.difficulty == selectedDifficulty
            let matchesCategory = selectedCategory == nil || exercise.category == selectedCategory
            let matchesSearch = searchText.isEmpty || 
                exercise.name.localizedCaseInsensitiveContains(searchText) ||
                exercise.description.localizedCaseInsensitiveContains(searchText)
            return matchesDifficulty && matchesCategory && matchesSearch
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                Text("Тренировки")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                // Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Поиск видео...", text: $searchText)
                }
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                
                // Difficulty selector
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(Difficulty.allCases, id: \.self) { difficulty in
                            Button(action: { selectedDifficulty = difficulty }) {
                                Text(difficulty.rawValue)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(selectedDifficulty == difficulty ? Color.blue : Color.clear)
                                    .foregroundColor(selectedDifficulty == difficulty ? .white : .primary)
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding()
                }
                
                // Category filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        Button(action: { selectedCategory = nil }) {
                            Text("Все")
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(selectedCategory == nil ? Color.blue : Color.clear)
                                .foregroundColor(selectedCategory == nil ? .white : .primary)
                                .cornerRadius(20)
                        }
                        
                        ForEach(ExerciseCategory.allCases, id: \.self) { category in
                            Button(action: { selectedCategory = category }) {
                                Text(category.rawValue)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(selectedCategory == category ? Color.blue : Color.clear)
                                    .foregroundColor(selectedCategory == category ? .white : .primary)
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding()
                }
                
                // Exercise list
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(filteredExercises) { exercise in
                            ExerciseCard(exercise: exercise)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
                
                Button(action: {
                    showTimerView = true
                }) {
                    Text("Начать тренировку")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }
}

struct ExerciseCard: View {
    let exercise: Exercise
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(exercise.name)
                .font(.headline)
            
            Text(exercise.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                Text(exercise.category.rawValue)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
                
                Text(exercise.difficulty.rawValue)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.green.opacity(0.2))
                    .cornerRadius(8)
                
                Spacer()
                
                if let reps = exercise.repetitions {
                    Text("\(reps) повторений")
                        .font(.caption)
                } else {
                    Text("\(exercise.duration) сек")
                        .font(.caption)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct TimerView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var roundDuration: Int
    @Binding var restDuration: Int
    @Binding var numberOfRounds: Int
    @Binding var isTimerRunning: Bool
    @Binding var currentRound: Int
    @Binding var timer: Timer?
    @Binding var remainingTime: Int

    @State private var isActive = false
    @State private var currentRoundState = 1
    @State private var timeRemaining = 180 // 3 minutes default
    @State private var isRest = false
    
    let roundDurationState = 180 // 3 minutes
    let restDurationState = 60 // 1 minute
    let totalRoundsState = 3
    
    private let timerState = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            // Background color
            (isRest ? Color.green : Color.red)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Title
                Text(isRest ? "Отдых" : "Раунд \(currentRoundState)/\(totalRoundsState)")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                
                // Timer
                Text(timeString(from: timeRemaining))
                    .font(.system(size: 70, weight: .bold))
                    .foregroundColor(.white)
                
                // Controls
                HStack(spacing: 40) {
                    // Reset button
                    Button(action: resetTimer) {
                        Image(systemName: "arrow.clockwise.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                    }
                    
                    // Play/Pause button
                    Button(action: toggleTimer) {
                        Image(systemName: isActive ? "pause.circle.fill" : "play.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                    }
                    
                    // Close button
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .onReceive(timerState) { _ in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                if isRest {
                    // Rest period ended, start next round
                    currentRoundState += 1
                    if currentRoundState > totalRoundsState {
                        // Workout complete
                        isActive = false
                        currentRoundState = 1
                        isRest = false
                        timeRemaining = roundDurationState
                    } else {
                        // Start next round
                        isRest = false
                        timeRemaining = roundDurationState
                    }
                } else {
                    // Round ended, start rest period
                    isRest = true
                    timeRemaining = restDurationState
                }
            }
        }
        .onAppear {
            timeRemaining = roundDuration
            currentRoundState = currentRound
        }
    }
    
    private func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%d:%02d", minutes, remainingSeconds)
    }
    
    private func toggleTimer() {
        isActive.toggle()
    }
    
    private func resetTimer() {
        isActive = false
        currentRoundState = 1
        isRest = false
        timeRemaining = roundDuration
    }
}

struct RecommendationsView: View {
    @Binding var showFAQ: Bool
    @Binding var showQuestionForm: Bool
    @Binding var questionText: String
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Заголовок
                    Text("Советы и рекомендации")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    // Рекомендации по тренировкам
                    SectionView(title: "Персонализированные тренировки", items: [
                        "Для новичков: тренировки с низкой нагрузкой",
                        "Для опытных: интенсивные тренировки с целевыми результатами"
                    ])
                    
                    // Рекомендации по питанию
                    SectionView(title: "Рекомендации по питанию", items: [
                        "Продукты для набора мышечной массы",
                        "Диета для сжигания жира"
                    ])
                    
                    // Советы по технике выполнения упражнений
                    SectionView(title: "Техника выполнения упражнений", items: [
                        "Как правильно приседать",
                        "Как избегать травм при подъеме тяжестей"
                    ])
                    
                    // Вдохновляющие истории успеха
                    SectionView(title: "Истории успеха", items: [
                        "Как Иван похудел на 20 кг за 6 месяцев",
                        "История Ольги: как йога помогла справиться с болью в спине"
                    ])
                    
                    // Кнопки для вопросов и FAQ
                    HStack {
                        Button(action: { showFAQ.toggle() }) {
                            Text("FAQ")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        
                        Button(action: { showQuestionForm.toggle() }) {
                            Text("Задать вопрос")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 20)
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SectionView: View {
    var title: String
    var items: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(.yellow)
                .padding(.bottom, 8)
            
            ForEach(items, id: \.self) { item in
                Text(item)
                    .padding(.vertical, 4)
                    .foregroundColor(.white)
            }
            
            Divider()
                .background(Color.yellow)
                .padding(.top, 8)
        }
        .padding(.vertical)
    }
}

struct FAQView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Общие вопросы")) {
                    Text("Как выбрать тренажер для дома?")
                    Text("Что делать, если я не могу выполнять упражнение правильно?")
                    Text("Как не потерять мотивацию?")
                }
                
                Section(header: Text("Питание и диеты")) {
                    Text("Что есть перед тренировкой?")
                    Text("Какие продукты лучше для роста мышц?")
                    Text("Какая диета лучше при снижении веса?")
                }
                
                Section(header: Text("Восстановление и травмы")) {
                    Text("Как избежать травм при тренировках?")
                    Text("Как восстановиться после интенсивной тренировки?")
                    Text("Как правильно растягиваться после тренировки?")
                }
            }
            .navigationBarTitle("FAQ")
        }
    }
}

struct QuestionFormView: View {
    @Binding var questionText: String
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Задайте свой вопрос")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)
                
                TextField("Введите ваш вопрос...", text: $questionText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: submitQuestion) {
                    Text("Отправить вопрос")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Задать вопрос", displayMode: .inline)
        }
    }
    
    private func submitQuestion() {
        // Логика для отправки вопроса
        print("Вопрос отправлен: \(questionText)")
    }
}

struct ChatView: View {
    var body: some View {
        Text("Чат с тренером")
            .font(.title)
            .padding()
    }
}

struct HealthRecoveryView: View {
    var body: some View {
        Text("Здоровье и восстановление")
            .font(.title)
            .padding()
    }
}

struct TimerSettingsView: View {
    @Binding var roundDuration: Int
    @Binding var restDuration: Int
    @Binding var numberOfRounds: Int
    @Binding var isTimerRunning: Bool
    @Binding var currentRound: Int
    @Binding var timer: Timer?
    @Binding var remainingTime: Int
    @Binding var showTimerView: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Настройки таймера")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)
                
                // Длительность раунда
                VStack(alignment: .leading, spacing: 10) {
                    Text("Длительность раунда: \(roundDuration) сек")
                    HStack {
                        Button("-10") {
                            if roundDuration > 10 {
                                roundDuration -= 10
                            }
                        }
                        .buttonStyle(.bordered)
                        
                        Button("+10") {
                            roundDuration += 10
                        }
                        .buttonStyle(.bordered)
                    }
                }
                .padding()
                
                // Длительность отдыха
                VStack(alignment: .leading, spacing: 10) {
                    Text("Длительность отдыха: \(restDuration) сек")
                    HStack {
                        Button("-10") {
                            if restDuration > 10 {
                                restDuration -= 10
                            }
                        }
                        .buttonStyle(.bordered)
                        
                        Button("+10") {
                            restDuration += 10
                        }
                        .buttonStyle(.bordered)
                    }
                }
                .padding()
                
                // Количество раундов
                VStack(alignment: .leading, spacing: 10) {
                    Text("Количество раундов: \(numberOfRounds)")
                    HStack {
                        Button("-1") {
                            if numberOfRounds > 1 {
                                numberOfRounds -= 1
                            }
                        }
                        .buttonStyle(.bordered)
                        
                        Button("+1") {
                            numberOfRounds += 1
                        }
                        .buttonStyle(.bordered)
                    }
                }
                .padding()
                
                Button(action: {
                    remainingTime = roundDuration
                    currentRound = 1
                    showTimerView = true
                }) {
                    Text("Начать тренировку")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                .padding()
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Настройки таймера", displayMode: .inline)
        }
    }
}

// MARK: - Achievement Models
enum Rank: String, CaseIterable {
    case novice = "Новичок"
    case amateur = "Любитель"
    case intermediate = "Продвинутый"
    case professional = "Профессионал"
    case master = "Мастер"
    
    var level: Int {
        switch self {
        case .novice: return 1
        case .amateur: return 2
        case .intermediate: return 3
        case .professional: return 4
        case .master: return 5
        }
    }
    
    var color: Color {
        switch self {
        case .novice: return .blue
        case .amateur: return .green
        case .intermediate: return .orange
        case .professional: return .red
        case .master: return .purple
        }
    }
}

struct Achievement: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let icon: String
    let current: Int
    let total: Int
}

// MARK: - Achievements View
struct AchievementsView: View {
    @State private var currentRank: Rank = .novice
    let achievements: [Achievement] = [
        Achievement(title: "Первые шаги", description: "Выполните 5 тренировок", icon: "figure.walk", current: 3, total: 5),
        Achievement(title: "Мастер комбо", description: "Выполните 10 комбинаций", icon: "bolt.fill", current: 7, total: 10),
        Achievement(title: "Выносливость", description: "Тренируйтесь 30 минут", icon: "heart.fill", current: 20, total: 30)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Текущий ранг
                    VStack(spacing: 16) {
                        Text("Ваш текущий ранг")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(Rank.allCases, id: \.self) { rank in
                                    VStack {
                                        ZStack {
                                            Circle()
                                                .fill(rank == currentRank ? rank.color : .gray.opacity(0.3))
                                                .frame(width: 60, height: 60)
                                            
                                            Image(systemName: rank == currentRank ? "star.fill" : "star")
                                                .foregroundColor(.white)
                                                .font(.system(size: 24))
                                        }
                                        
                                        Text(rank.rawValue)
                                            .font(.subheadline)
                                        
                                        Text("Уровень \(rank.level)")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    .frame(width: 120)
                                    .padding()
                                    .background(rank == currentRank ? rank.color.opacity(0.1) : Color.clear)
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(rank == currentRank ? rank.color : Color.clear, lineWidth: 2)
                                    )
                                    .onTapGesture {
                                        withAnimation(.spring()) {
                                            currentRank = rank
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding()
                    
                    // Прогресс до следующего ранга
                    if currentRank != .master {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Прогресс до следующего ранга")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            GeometryReader { geometry in
                                ZStack(alignment: .leading) {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(height: 8)
                                        .cornerRadius(4)
                                    
                                    Rectangle()
                                        .fill(currentRank.color)
                                        .frame(width: geometry.size.width * 0.7, height: 8)
                                        .cornerRadius(4)
                                }
                            }
                            .frame(height: 8)
                            
                            HStack {
                                Text(currentRank.rawValue)
                                Spacer()
                                Text(Rank.allCases[min(currentRank.level, Rank.allCases.count - 1)].rawValue)
                            }
                            .font(.caption)
                            .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                    
                    // Достижения
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Достижения")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        ForEach(achievements) { achievement in
                            AchievementRow(achievement: achievement)
                        }
                    }
                }
            }
            .navigationTitle("Достижения")
        }
    }
}

struct AchievementRow: View {
    let achievement: Achievement
    
    var progress: CGFloat {
        CGFloat(achievement.current) / CGFloat(achievement.total)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                ZStack {
                    Circle()
                        .fill(Color.blue.opacity(0.2))
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: achievement.icon)
                        .foregroundColor(.blue)
                        .font(.system(size: 20))
                }
                
                VStack(alignment: .leading) {
                    Text(achievement.title)
                        .fontWeight(.semibold)
                    
                    Text(achievement.description)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Text("\(achievement.current)/\(achievement.total)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 6)
                        .cornerRadius(3)
                    
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing))
                        .frame(width: geometry.size.width * progress, height: 6)
                        .cornerRadius(3)
                }
            }
            .frame(height: 6)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

// MARK: - Statistics Models
struct HealthMetrics {
    var currentPulse: Int
    var stressLevel: Int
    var sleepHours: Double
    var weeklyProgress: [HealthDataPoint]
    var recommendations: [String]
}

struct HealthDataPoint: Identifiable {
    let id = UUID()
    let day: String
    let value: Double
}

// MARK: - Statistics View
struct StatisticsView: View {
    let statistics = HealthMetrics(
        currentPulse: 62,
        stressLevel: 35,
        sleepHours: 1.77,
        weeklyProgress: [
            HealthDataPoint(day: "Пн", value: 65),
            HealthDataPoint(day: "Вт", value: 70),
            HealthDataPoint(day: "Ср", value: 68),
            HealthDataPoint(day: "Чт", value: 75),
            HealthDataPoint(day: "Пт", value: 72),
            HealthDataPoint(day: "Сб", value: 78),
            HealthDataPoint(day: "Вс", value: 80)
        ],
        recommendations: [
            "Пейте больше воды",
            "Применяйте растяжку после тренировки",
            "Соблюдайте режим сна"
        ]
    )
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // График
                    Chart(statistics.weeklyProgress) { point in
                        BarMark(
                            x: .value("День", point.day),
                            y: .value("Показатель", point.value)
                        )
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.orange, .orange.opacity(0.5)],
                                startPoint: .bottom,
                                endPoint: .top
                            )
                        )
                        .cornerRadius(8)
                    }
                    .frame(height: 200)
                    .padding()
                    
                    // Общая статистика
                    VStack(alignment: .leading, spacing: 16) {
                        Text("ОБЩАЯ СТАТИСТИКА")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        StatCard(title: "Всего тренировок", value: "\(statistics.currentPulse)")
                        StatCard(title: "Общее время", value: "\(statistics.stressLevel) часа")
                        StatCard(title: "Средняя длительность", value: "\(statistics.sleepHours) часа")
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Статистика")
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Social Models
struct SocialMessage: Identifiable {
    let id = UUID()
    let user: String
    let content: String
    let timestamp: Date
    let attachment: SocialAttachment?
}

enum SocialAttachment {
    case workout(title: String, duration: Int)
    case achievement(title: String)
    case challenge(title: String, description: String)
    case photo
}

struct SocialGroup: Identifiable {
    let id = UUID()
    let name: String
    let members: Int
    let isPrivate: Bool
}

// MARK: - Social Views
struct SocialView: View {
    @StateObject private var chatViewModel = ChatViewModel()
    @State private var messages: [SocialMessage] = [
        SocialMessage(user: "Константин", content: "Отлично! Только что закончил 12 раундов", timestamp: Date(), attachment: .workout(title: "Тренировка выносливости", duration: 45)),
        SocialMessage(user: "Анна", content: "Кто хочет присоединиться к групповой тренировке?", timestamp: Date(), attachment: nil)
    ]
    
    @State private var groups: [SocialGroup] = [
        SocialGroup(name: "Утренние тренировки", members: 12, isPrivate: false),
        SocialGroup(name: "Про боксеры", members: 28, isPrivate: true)
    ]
    
    @State private var messageText = ""
    @State private var showingSocialAttachmentMenu = false
    @State private var showingGroupCreation = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Верхняя панель
                HStack {
                    Text("Чат")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button(action: { showingGroupCreation.toggle() }) {
                        HStack {
                            Image(systemName: "person.3.fill")
                            Text("Создать группу")
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(20)
                    }
                }
                .padding()
                
                // Список сообщений
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(messages) { message in
                            SocialMessageRow(message: message)
                        }
                    }
                    .padding()
                }
                
                // Поле ввода сообщения
                VStack(spacing: 0) {
                    Divider()
                    HStack(spacing: 12) {
                        Button(action: { showingSocialAttachmentMenu.toggle() }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.yellow)
                        }
                        
                        TextField("Сообщение...", text: $messageText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button(action: sendMessage) {
                            Image(systemName: "arrow.up.circle.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.yellow)
                        }
                    }
                    .padding()
                }
            }
            .sheet(isPresented: $showingSocialAttachmentMenu) {
                SocialAttachmentMenuView()
            }
            .sheet(isPresented: $showingGroupCreation) {
                SocialGroupCreationView()
            }
        }
    }
    
    func sendMessage() {
        guard !messageText.isEmpty else { return }
        let newMessage = SocialMessage(user: "Вы", content: messageText, timestamp: Date(), attachment: nil)
        messages.append(newMessage)
        messageText = ""
    }
}

struct SocialMessageRow: View {
    let message: SocialMessage
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(message.user)
                    .fontWeight(.semibold)
                
                Text(message.timestamp, style: .time)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Text(message.content)
            
            if let attachment = message.attachment {
                socialAttachmentView(for: attachment)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    @ViewBuilder
    func socialAttachmentView(for attachment: SocialAttachment) -> some View {
        switch attachment {
        case .workout(let title, let duration):
            HStack {
                Image(systemName: "figure.walk")
                VStack(alignment: .leading) {
                    Text(title)
                        .fontWeight(.medium)
                    Text("\(duration) минут")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding(8)
            .background(Color.blue.opacity(0.1))
            .cornerRadius(8)
            
        case .achievement(let title):
            HStack {
                Image(systemName: "trophy.fill")
                    .foregroundColor(.yellow)
                Text(title)
                    .fontWeight(.medium)
            }
            .padding(8)
            .background(Color.yellow.opacity(0.1))
            .cornerRadius(8)
            
        case .challenge(let title, let description):
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "flame.fill")
                        .foregroundColor(.orange)
                    Text(title)
                        .fontWeight(.medium)
                }
                Text(description)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(8)
            .background(Color.orange.opacity(0.1))
            .cornerRadius(8)
            
        case .photo:
            Image(systemName: "photo.fill")
                .font(.largeTitle)
                .foregroundColor(.blue)
        }
    }
}

struct SocialAttachmentMenuView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                SocialAttachmentButton(icon: "photo", title: "Фото", color: .blue)
                SocialAttachmentButton(icon: "figure.walk", title: "Тренировка", color: .green)
                SocialAttachmentButton(icon: "trophy", title: "Достижение", color: .yellow)
                SocialAttachmentButton(icon: "flame", title: "Вызов", color: .red)
            }
            .navigationTitle("Прикрепить")
            .navigationBarItems(trailing: Button("Готово") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct SocialAttachmentButton: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.title2)
            Text(title)
        }
        .padding(.vertical, 8)
    }
}

struct SocialGroupCreationView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var groupName = ""
    @State private var isPrivate = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Информация о группе")) {
                    TextField("Название группы", text: $groupName)
                    Toggle("Приватная группа", isOn: $isPrivate)
                }
            }
            .navigationTitle("Создать группу")
            .navigationBarItems(
                leading: Button("Отмена") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Создать") {
                    // TODO: Create group
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

// MARK: - Health Views
struct HealthView: View {
    @State private var healthMetrics = HealthMetrics(
        currentPulse: 72,
        stressLevel: 35,
        sleepHours: 7.5,
        weeklyProgress: [
            HealthDataPoint(day: "Пн", value: 65),
            HealthDataPoint(day: "Вт", value: 70),
            HealthDataPoint(day: "Ср", value: 68),
            HealthDataPoint(day: "Чт", value: 75),
            HealthDataPoint(day: "Пт", value: 72),
            HealthDataPoint(day: "Сб", value: 78),
            HealthDataPoint(day: "Вс", value: 80)
        ],
        recommendations: [
            "Пейте больше воды",
            "Применяйте растяжку после тренировки",
            "Соблюдайте режим сна"
        ]
    )
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Заголовок
                    Text("Здоровье и восстановление")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    // График прогресса за неделю
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Здоровье за последнюю неделю")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        Chart(healthMetrics.weeklyProgress) { point in
                            LineMark(
                                x: .value("День", point.day),
                                y: .value("Показатель", point.value)
                            )
                            .foregroundStyle(.green)
                            
                            PointMark(
                                x: .value("День", point.day),
                                y: .value("Показатель", point.value)
                            )
                            .foregroundStyle(.green)
                        }
                        .frame(height: 200)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Текущие показатели
                    VStack(spacing: 16) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Текущий пульс")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                
                                Text("\(healthMetrics.currentPulse) bpm")
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(.green)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "heart.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.green)
                        }
                        
                        Divider()
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Уровень стресса")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                
                                Text("\(healthMetrics.stressLevel)%")
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(.orange)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "brain.head.profile")
                                .font(.system(size: 40))
                                .foregroundColor(.orange)
                        }
                        
                        Divider()
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Сон")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                
                                Text(String(format: "%.1f ч", healthMetrics.sleepHours))
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(.blue)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "moon.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Рекомендации
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Рекомендации по восстановлению")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        ForEach(healthMetrics.recommendations, id: \.self) { recommendation in
                            HStack(spacing: 12) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                
                                Text(recommendation)
                                    .font(.subheadline)
                                
                                Spacer()
                            }
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Кнопка обновления
                    Button(action: updateHealthMetrics) {
                        Text("Отметить восстановление")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
        }
    }
    
    func updateHealthMetrics() {
        // Здесь будет интеграция с фитнес-трекером
        withAnimation {
            healthMetrics.currentPulse = Int.random(in: 65...85)
            healthMetrics.stressLevel = Int.random(in: 20...60)
            healthMetrics.sleepHours = Double.random(in: 6...9)
            
            // Обновляем последнее значение в графике
            var newProgress = healthMetrics.weeklyProgress
            newProgress.removeFirst()
            newProgress.append(HealthDataPoint(day: "Вс", value: Double(healthMetrics.currentPulse)))
            healthMetrics.weeklyProgress = newProgress
        }
    }
}

struct HomeView: View {
    @State private var showTimerView = false
    @State private var showExerciseView = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                // Заголовок
                Text("Привет, Боец!")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 40)
                
                // Быстрый старт
                Button {
                    showTimerView = true
                } label: {
                    HStack(spacing: 16) {
                        Image(systemName: "bolt.fill")
                            .font(.title)
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Быстрый старт")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("3 раунда × 3 минуты")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.title3)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.orange.opacity(0.3))
                    .cornerRadius(16)
                }
                .padding(.horizontal)
                
                // Упражнения
                Button {
                    showExerciseView = true
                } label: {
                    HStack(spacing: 16) {
                        Image(systemName: "figure.boxing")
                            .font(.title)
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Упражнения")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("Тренировки на все группы мышц")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.title3)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(16)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(0.8), Color.black]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .sheet(isPresented: $showTimerView) {
            TimerView(
                roundDuration: .constant(180),  // 3 минуты
                restDuration: .constant(60),    // 1 минута отдыха
                numberOfRounds: .constant(3),   // 3 раунда
                isTimerRunning: .constant(false),
                currentRound: .constant(0),
                timer: .constant(nil),
                remainingTime: .constant(0)
            )
        }
        .sheet(isPresented: $showExerciseView) {
            ExerciseTrainingView(
                searchText: .constant(""),
                selectedDifficulty: .constant(.beginner),
                selectedCategory: .constant(nil),
                showTimerView: $showTimerView
            )
        }
    }
}

#Preview {
    MainScreen()
}
