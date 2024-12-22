import SwiftUI

struct Tip: Identifiable {
    let id = UUID()
    let title: String
    let content: String
    let image: String
    let category: String
    var likes: Int
    var isSaved: Bool
}

struct TipCategory: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let color: Color
    var tips: [Tip]
}
