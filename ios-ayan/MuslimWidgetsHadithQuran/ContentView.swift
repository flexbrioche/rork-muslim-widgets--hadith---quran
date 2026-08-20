import SwiftUI

/// Root tab navigation — three primary screens.
struct ContentView: View {

    @State private var appState = AppState()
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            DailyFeedView()
                .environment(appState)
                .tabItem {
                    Image(systemName: "sparkles")
                    Text("Today")
                }
                .tag(0)

            WidgetStudioView()
                .environment(appState)
                .tabItem {
                    Image(systemName: "wand.and.stars")
                    Text("Widget")
                }
                .tag(1)

            SavedView()
                .environment(appState)
                .tabItem {
                    Image(systemName: "bookmark.fill")
                    Text("Saved")
                }
                .tag(2)
        }
        .tint(MuslimWidgetsHadithQuranDesign.gold)
        .background(MuslimWidgetsHadithQuranDesign.canvas)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
