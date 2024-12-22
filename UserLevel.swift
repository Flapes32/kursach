import Foundation

enum BoxingRank: String, CaseIterable {
    case rookie = "Новичок"
    case amateur = "Любитель"
    case intermediate = "Полупрофессионал"
    case professional = "Профессионал"
    case champion = "Чемпион"
    case legend = "Легенда"
    
    var requiredLevel: Int {
        switch self {
        case .rookie: return 1
        case .amateur: return 5
        case .intermediate: return 10
        case .professional: return 20
        case .champion: return 35
        case .legend: return 50
        }
    }
    
    var iconName: String {
        switch self {
        case .rookie: return "1.circle"
        case .amateur: return "figure.boxing"
        case .intermediate: return "star.fill"
        case .professional: return "star.circle.fill"
        case .champion: return "crown.fill"
        case .legend: return "trophy.fill"
        }
    }
    
    var color: String {
        switch self {
        case .rookie: return "gray"
        case .amateur: return "blue"
        case .intermediate: return "green"
        case .professional: return "purple"
        case .champion: return "orange"
        case .legend: return "gold"
        }
    }
}

class UserLevel: ObservableObject {
    @Published var currentXP: Int = 0
    @Published var level: Int = 1
    
    var xpForNextLevel: Int {
        return level * 100
    }
    
    var progress: Double {
        Double(currentXP) / Double(xpForNextLevel)
    }
    
    var currentRank: BoxingRank {
        let rank = BoxingRank.allCases.last { level >= $0.requiredLevel }
        return rank ?? .rookie
    }
    
    func addXP(_ amount: Int) {
        currentXP += amount
        while currentXP >= xpForNextLevel {
            levelUp()
        }
    }
    
    private func levelUp() {
        currentXP -= xpForNextLevel
        level += 1
    }
}
