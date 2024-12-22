import SwiftUI

struct AttachmentMenuView: View {
    @ObservedObject var viewModel: ChatViewModel
    
    var body: some View {
        NavigationView {
            List {
                Button(action: { /* Логика для прикрепления изображения */ }) {
                    Text("Прикрепить изображение")
                }
                Button(action: { /* Логика для прикрепления тренировки */ }) {
                    Text("Прикрепить тренировку")
                }
                Button(action: { /* Логика для прикрепления достижения */ }) {
                    Text("Прикрепить достижение")
                }
                Button(action: { /* Логика для прикрепления вызова */ }) {
                    Text("Прикрепить вызов")
                }
            }
            .navigationTitle("Выберите вложение")
        }
    }
}
