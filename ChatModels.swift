import Foundation
import SwiftUI

struct User: Identifiable, Codable, Hashable {
    let id: String
    var username: String
    var profileImage: String
    var status: UserStatus
    var achievements: [Achievement]
    var friendsList: [String] // IDs of friends
    var workoutStats: WorkoutStats
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct WorkoutStats: Codable {
    var totalWorkouts: Int
    var averageTime: TimeInterval
    var bestTime: TimeInterval
    var totalRounds: Int
    var level: Int
    var experience: Int
}

enum UserStatus: String, Codable {
    case online
    case offline
    case training
    case resting
}

struct ChatMessage: Identifiable, Codable {
    let id: String
    let senderId: String
    let receiverId: String?
    let content: String
    let timestamp: Date
    var type: MessageType
    var reactions: [MessageReaction]
    var attachments: [MessageAttachment]?
}

enum MessageType: String, Codable {
    case text
    case image
    case workout
    case achievement
    case challenge
}

struct MessageReaction: Codable {
    let userId: String
    let type: ReactionType
}

enum ReactionType: String, Codable {
    case like = "👍"
    case love = "❤️"
    case fire = "🔥"
    case muscle = "💪"
    case boxing = "🥊"
}

struct MessageAttachment: Codable {
    let id: String
    let type: AttachmentType
    let url: String
    var metadata: [String: String]?
}

enum AttachmentType: String, Codable {
    case image
    case video
    case workout
    case achievement
}

struct ChatRoom: Identifiable, Codable {
    let id: String
    var name: String
    var participants: [String] // User IDs
    var lastMessage: ChatMessage?
    var type: ChatRoomType
    var metadata: ChatRoomMetadata
}

enum ChatRoomType: String, Codable {
    case direct
    case group
    case team
    case challenge
}

struct ChatRoomMetadata: Codable {
    var isPrivate: Bool
    var teamLevel: Int?
    var challengeType: ChallengeType?
    var createdAt: Date
    var description: String?
}

enum ChallengeType: String, Codable {
    case timeChallenge
    case roundsChallenge
    case enduranceChallenge
    case teamChallenge
}
