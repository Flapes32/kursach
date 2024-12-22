import SwiftUI

struct HealthMetric: Identifiable {
    let id = UUID()
    let name: String
    let value: Double
    let unit: String
    let icon: String
    let color: Color
    let description: String
    let recommendation: String
}

struct RecoveryTip: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let icon: String
    let color: Color
    let duration: Int // в минутах
    let intensity: String
}
