import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    
    func sendMessage(_ messageText: String) {
        let newMessage = ChatMessage(content: messageText, timestamp: Date(), isFromCurrentUser: true)
        messages.append(newMessage)
    }
    
    func createNewGroup() {
        // Логика для создания новой группы
    }
    
    func showLeaderboard() {
        // Логика для показа таблицы лидеров
    }
}

struct ChatMessage: Identifiable {
    let id = UUID()
    var content: String
    var timestamp: Date
    var isFromCurrentUser: Bool
    var attachments: [MessageAttachment] = []
    var reactions: [String] = []
}

struct MessageAttachment: Identifiable {
    let id = UUID()
    var type: AttachmentType
    var content: String
}

enum AttachmentType {
    case image
    case workout
    case achievement
    case challenge
}
