import SwiftUI

// MARK: - Health Models
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
    let duration: Int
    let intensity: String
}

// MARK: - Tips Models
struct TipCategory: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let color: Color
    var tips: [Tip]
}

struct Tip: Identifiable {
    let id = UUID()
    let title: String
    let content: String
    let image: String
    let category: String
    var likes: Int
    var isSaved: Bool
}

// MARK: - Social Models
struct ChatRoom: Identifiable {
    let id = UUID()
    let name: String
    let lastMessage: String
    let unreadCount: Int
}

struct ChatMessage: Identifiable {
    let id = UUID()
    let content: String
    let isFromCurrentUser: Bool
    let timestamp: Date
    var reactions: [String]
    var attachments: [MessageAttachment]
}

struct MessageAttachment: Identifiable {
    let id = UUID()
    let type: AttachmentType
    let content: String // URL или текст
}

enum AttachmentType {
    case image
    case workout
    case achievement
    case challenge
}

struct User: Identifiable {
    let id = UUID()
    let name: String
    let avatar: String
    var status: UserStatus
}

enum UserStatus {
    case online
    case offline
    case training
}

struct Challenge: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let reward: String
    var participants: [User]
}

struct Team: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let avatar: String
    var members: [User]
}
