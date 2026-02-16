import SwiftUI

@main
struct MyApp: App {
    @State var emergencyManager = EmergencyManager()
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationStack {
                    TravelView(immediateEmergencies: emergencyManager.immediateEmergencies, roadWeatherEmergencies: emergencyManager.roadWeatherEmergencies, vehicleEmergencies: emergencyManager.vehicleEmergencies)
//                            .preferredColorScheme(ColorScheme.dark)
                }
                .tabItem {
                    Label("Emergencies", systemImage: "light.beacon.max.fill")
                }
                NavigationStack {
                    AttentionView()
                }
                .tabItem {
                    Label("Attention", systemImage: "road.lanes.curved.left")
                }
                NavigationStack {
                    ResourcesView()
                }
                .tabItem {
                    Label("Resources", systemImage: "book.pages.fill")
                }
            }
        }
        .modelContainer(for: ContactModel.self)
    }
}
