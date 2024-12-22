import SwiftUI
import SafariServices

struct ContentView: View {
    var body: some View {
        MainScreen()
            .preferredColorScheme(.dark)
            .accentColor(.yellow)
    }
}

@main
struct BoxingApp: App {
    var body: some Scene {
        WindowGroup {
            MainScreen()
        }
    }
}
