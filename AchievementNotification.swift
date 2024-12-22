import SwiftUI

struct AchievementNotification: View {
    let achievement: Achievement
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: achievement.iconName)
                .font(.system(size: 40))
                .foregroundColor(.yellow)
            
            Text("Новое достижение!")
                .font(.headline)
                .foregroundColor(.white)
            
            Text(achievement.title)
                .font(.title2)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
            
            Text(achievement.description)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
            
            Button(action: {
                withAnimation {
                    isPresented = false
                }
            }) {
                Text("Отлично!")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppColors.primary)
                    .cornerRadius(12)
            }
        }
        .padding(24)
        .background(Color(.systemGray6))
        .cornerRadius(20)
        .shadow(radius: 20)
        .padding(.horizontal, 40)
    }
}

struct AchievementToast: ViewModifier {
    @Binding var achievement: Achievement?
    @State private var showToast = false
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if let achievement = achievement {
                VStack {
                    Spacer()
                    AchievementNotification(achievement: achievement, isPresented: .constant(true))
                        .transition(.move(edge: .bottom))
                        .animation(.spring())
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation {
                                    self.achievement = nil
                                }
                            }
                        }
                }
                .zIndex(1)
            }
        }
    }
}

extension View {
    func achievementToast(achievement: Binding<Achievement?>) -> some View {
        modifier(AchievementToast(achievement: achievement))
    }
}
